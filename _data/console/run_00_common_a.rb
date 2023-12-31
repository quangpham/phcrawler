# Buoc 1
# Init tmp

def init_tmp
  system "mkdir -p tmp/run/ && rm -R tmp/run* && mkdir -p tmp/run/"
  system "cp _data/scripts/*.sh tmp/run/"
  system "touch tmp/run/run.sh && chmod u+x tmp/run/run.sh"
end


def slipt_commands_to_files commands, number_split_files = 15
  init_tmp()
  content_arr = []
  number_split_files.times {content_arr.push([])}

  File.open("tmp/run/run.sh", 'w') { |file| file.write( number_split_files.times.collect {|i| "./#{i}.sh &" }.join("\n") ) }

  commands.each_with_index do |c,i|
    content_arr[i%number_split_files].push(c)
  end

  content_arr.each_with_index do |arr,i|
    File.open("tmp/run/#{i}.sh", 'w') { |file| file.write(arr.join(" \n")) }
    system "chmod u+x tmp/run/#{i}.sh"
  end

  system "cd tmp/ && zip -r run.zip run/"
end

def parse_json string
  JSON.parse(string) rescue nil
end

def helper_get_node_by_path n, path, obj_type = nil
  path_arr = path.kind_of?(Array) ? path : "#{path.to_s}".gsub(" ","").split(",")
  return nil if path_arr.empty?

  if path_arr.count == 1
    v = n[path_arr.first]
    return nil if v.nil?
    if obj_type.blank?
      return v
    elsif obj_type == "int"
      return v.to_i == 0 ? nil : v.to_i
    elsif obj_type == "string"
      return v == "" ? nil : v
    elsif obj_type == "bool"
      return v == false ? nil : v
    elsif obj_type == "array"
      return v.empty? ? nil : v
    end
  else
    if n[path_arr.first]
      return helper_get_node_by_path(n[path_arr.first], path_arr.drop(1), obj_type)
    else
      return nil
    end
  end

end

# fn = "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp/user-profiles/byosko.json"
# data = JSON.parse(File.read(fn))
# helper_get_node_by_path(data, "data,profile,b", "array")
# helper_get_node_by_path(data, "data,profile,id", "int")

def helper_get_user_collection_by_node_data n
  c = UserCollection.find_or_initialize_by(id: n["id"].to_i)
  c.name = n["name"]
  c.title = n["title"]
  c.description = n["description"]
  c.path = n["path"]
  c.products_count = n["productsCount"].to_i
  c.org_created_at = n["createdAt"]

  if edges = helper_get_node_by_path(n, "products,edges", "array")
    c.product_ids = edges.collect { |e| e["node"]["id"].to_i }
  end

  return c
end

def helper_get_user_link_by_node_data ln
  l = UserLink.find_or_initialize_by(id: ln["id"].to_i)
  l.name = ln["name"]
  l.url = ln["url"]
  l.kind = ln["kind"]
  return l
end

def helper_save_user_to_json u
  File.write("/Users/quang/Downloads/ok/users-json/#{u["id"]}.json", u.to_json.to_s)
end

def helper_get_user_by_node_data u
  user_id = u["id"].to_i
  new_users = []

  user = User.find_or_initialize_by(id: user_id)
  user.username = u["username"].strip if !u["username"].nil? && !u["isTrashed"]
  user.fullscans_needed = true unless user.persisted?

  obj_map = [
    {key: "name", path: "name", obj_type: "string"},
    {key: "headline", path: "headline", obj_type: "string"},
    {key: "website", path: "websiteUrl", obj_type: "string"},
    {key: "avatar", path: "avatarUrl", obj_type: "string"},
    {key: "twitter", path: "twitterUsername", obj_type: "string"},
    {key: "about", path: "about", obj_type: "string"},
    {key: "org_created_at", path: "createdAt", obj_type: nil},
    {key: "job_title", path: "work,jobTitle", obj_type: "string"},
    {key: "company_name", path: "work,companyName", obj_type: "string"},
    {key: "work_product_id", path: "work,product,id", obj_type: "int"},
    {key: "is_maker", path: "isMaker", obj_type: "bool"},
    {key: "is_trashed", path: "isTrashed", obj_type: "bool"},
    {key: "followers", path: "followersCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "following", path: "followingsCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "badges", path: "badgesCount", obj_type: "int", get_max: true},
    {key: "products_count", path: "productsCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "collections_count", path: "collectionsCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "votes_count", path: "votesCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "submitted_posts_count", path: "submittedPostsCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "stacks_count", path: "stacksCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "score", path: "karmaBadge,score", obj_type: "int", get_max: true},
    {key: "activities_count", path: "activityEvents,totalCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "max_streak", path: "visitStreak,duration", obj_type: "int", get_max: true}
  ]

  obj_map.each do |m|
    if v = helper_get_node_by_path(u, m[:path], m[:obj_type])
      old_v = user[ m[:key] ]
      new_v = nil

      if m[:get_max] == true
        new_v = user[ m[:key] ].nil? ? v : [ user[ m[:key] ], v ].max
      else
        new_v = v
      end

      user[ m[:key] ] = new_v

      if m[:fullscans_check] == true && old_v != new_v
        user.fullscans_needed = true
      end

    end
  end

  # INIT
  arr_map = [
    ["followed_topic_ids", "gen_followed_topics_count"],
    ["follower_ids"],
    ["following_ids"],
    ["stack_product_ids"],
    ["submitted_post_ids"],
    ["voted_post_ids","gen_voted_posts_count"],
    ["collection_ids"],
    ["links", "gen_links_count"]
  ]
  arr_map.each do |m|
    user[m[0]] = [] if user[m[0]].nil?
  end

  if edges = helper_get_node_by_path(u, "followedTopics,edges", "array")
    user.followed_topic_ids += edges.collect { |e| e["node"]["id"].to_i }
  end

  if edges = helper_get_node_by_path(u, "followers,edges", "array")
    old_val = user.follower_ids.uniq.sort
    user.follower_ids += edges.collect { |e| e["node"]["id"].to_i }
    new_users += edges.collect { |e| {user_id: e["node"]["id"].to_i, username: e["node"]["username"]} }
    new_val = user.follower_ids.uniq.sort
    if old_val != new_val
      raw_sql = (new_val - old_val).collect {|i| "INSERT INTO user_followers (user_id, follower_id) VALUES(#{user.id}, #{i}) ON CONFLICT (user_id, follower_id) DO NOTHING;" }
      ActiveRecord::Base.connection.execute(raw_sql.join(";"))
    end
  end

  if edges = helper_get_node_by_path(u, "following,edges", "array")
    old_val = user.following_ids.uniq.sort
    user.following_ids += edges.collect { |e| e["node"]["id"].to_i }
    new_users += edges.collect { |e| {user_id: e["node"]["id"].to_i, username: e["node"]["username"]} }
    new_val = user.following_ids.uniq.sort
    if old_val != new_val
      raw_sql = (new_val - old_val).collect {|i| "INSERT INTO user_followings (user_id,following_id) VALUES(#{user.id},#{i}) ON CONFLICT (user_id,following_id) DO NOTHING;" }
      ActiveRecord::Base.connection.execute(raw_sql.join(";"))
    end
  end

  if edges = helper_get_node_by_path(u, "submittedPosts,edges", "array")
    user.submitted_post_ids += edges.collect { |e| e["node"]["id"].to_i }
  end

  if edges = helper_get_node_by_path(u, "votedPosts,edges", "array")
    old_val = user.voted_post_ids.uniq.sort
    user.voted_post_ids += edges.collect { |e| e["node"]["id"].to_i }
    new_val = user.voted_post_ids.uniq.sort
    if old_val != new_val
      raw_sql = (new_val - old_val).collect {|i| "INSERT INTO post_upvoter (user_id,post_id) VALUES(#{user.id},#{i}) ON CONFLICT (user_id,post_id) DO NOTHING;" }
      ActiveRecord::Base.connection.execute(raw_sql.join(";"))
    end
  end

  if edges = helper_get_node_by_path(u, "stacks,edges", "array")
    user.stack_product_ids += edges.collect { |e| e["node"]["product"]["id"].to_i }
  end

  if edges = helper_get_node_by_path(u, "collections,edges", "array")
    edges.each do |ce|
      c = helper_get_user_collection_by_node_data(ce["node"])
      c.user_id = user_id
      c.save
      user.collection_ids.push(c.id)
    end
  end

  if u["links"]
    u["links"].each do |ln|
      l = helper_get_user_link_by_node_data(ln)
      l.user_id = user_id
      l.save
      user.links.push(l.id)
    end
  end

  if u["badgeGroups"]
    u["badgeGroups"].each do |b|
      if b["badgesCount"] > 0
        if b["awardKind"].index("upvotes_") == 0
          v = b["awardKind"].gsub("upvotes_","").to_i
          user.upvotes_score = user.upvotes_score.nil? ? v : [user.upvotes_score, v].max
        elsif b["awardKind"].index("visit_streak_") == 0
          v = b["awardKind"].gsub("visit_streak_","").to_i
          user.visit_streak_score = user.visit_streak_score.nil? ? v : [user.visit_streak_score, v].max
        else
          user["#{b["awardKind"]}"]  = b["badgesCount"]
        end
      end
    end
  end

  if edges = helper_get_node_by_path(u, "activityEvents,edges", "array")
    if user.last_active_at.nil?
      user.last_active_at = edges[0]["node"]["occurredAt"]
    else
      user.last_active_at = [user.last_active_at, edges[0]["node"]["occurredAt"]].max
    end
  end

  arr_map.each do |m|
    if user[m[0]]
      user[m[0]] = user[m[0]].uniq.compact.sort
      if user[m[0]].empty?
        user[m[0]] = nil
      end

      if m[1]
         if user[m[0]]
          user[m[1]] = user[m[0]].count
         end
      end
    end
  end

  if !new_users.empty?
    raw_sql = new_users.uniq.collect {|nu| "INSERT INTO users (id,username,fullscans_needed,created_at,updated_at) VALUES(#{nu[:user_id]},'#{nu[:username]}',TRUE,NOW(),NOW()) ON CONFLICT (id) DO NOTHING;" }
    ActiveRecord::Base.connection.execute(raw_sql.join(";"))
  end

  if !user.avatar.nil?
    user.avatar = user.avatar.split("/#{user.id}/").last
    # user.avatar = nil if user.avatar == "original"
  end

  user.fullscans_needed = nil if user.is_trashed == true
  return user
end

def helper_get_post_by_node_data n
  post = Post.find_or_initialize_by(id: n["id"].to_i)
  post.fullscans_needed = true unless post.persisted?

  obj_map = [
    {key: "name", path: "name", obj_type: "string"},
    {key: "slug", path: "slug", obj_type: "string"},
    {key: "tagline", path: "tagline", obj_type: "string"},
    {key: "pricing_type", path: "pricingType", obj_type: "string"},
    {key: "comments_count", path: "commentsCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "votes_count", path: "votesCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "org_created_at", path: "createdAt", obj_type: nil},
    {key: "org_featured_at", path: "featuredAt", obj_type: nil},
    {key: "org_updated_at", path: "updatedAt", obj_type: nil}
  ]

  obj_map.each do |m|
    if v = helper_get_node_by_path(n, m[:path], m[:obj_type])
      old_v = post[ m[:key] ]
      new_v = nil

      if m[:get_max] == true
        new_v = post[ m[:key] ].nil? ? v : [ post[ m[:key] ], v ].max
      else
        new_v = v
      end

      post[ m[:key] ] = new_v

      if m[:fullscans_check] == true && old_v != new_v
        post.fullscans_needed = true
      end

    end
  end

  arr_map = [
    ["topic_ids"],
    ["hunter_ids"],
    ["maker_ids"],
    ["commenter_ids"],
    ["upvoter_ids"],
  ]

  arr_map.each do |m|
    post[m[0]] = [] if post[m[0]].nil?
  end

  if product_id = helper_get_node_by_path(n, "product,id", "int") || helper_get_node_by_path(n, "redirectToProduct,id", "int")
    post.product_id = product_id
    unless Product.find_by(id: product_id)
       product_slug = helper_get_node_by_path(n, "product,slug", "string") || helper_get_node_by_path(n, "redirectToProduct,slug", "string")
       Product.create(id: product_id, slug: product_slug, fullscans_needed: true)
    end
  end

  if edges = helper_get_node_by_path(n, "topics,edges", "array")
    post.topic_ids += edges.collect {|_n| _n["node"]["id"].to_i }
  end

  if contributors = helper_get_node_by_path(n, "contributors", "array")
    contributors.each do |_n|
      u = _n["user"]
      user_id = u["id"].to_i
      post.hunter_ids.push(user_id) if !_n["role"].index("hunter").nil?
      post.maker_ids.push(user_id) if !_n["role"].index("maker").nil?
      post.commenter_ids.push(user_id) if !_n["role"].index("commenter").nil?
      post.upvoter_ids.push(user_id) if !_n["role"].index("upvoter").nil?

      helper_save_user_to_json(u)
      # user = helper_get_user_by_node_data(u)
      # user.save
    end
  end

  arr_map.each do |m|
    if post[m[0]]
      post[m[0]] = post[m[0]].uniq.compact.sort
      if post[m[0]].empty?
        post[m[0]] = nil
      end
      if m[1]
         if post[m[0]]
          post[m[1]] = post[m[0]].count
         end
      end
    end
  end

  post.fullscans_needed = nil if post.is_trashed == true
  return post
end

def helper_get_product_by_node_data n
  product_id = n["id"].to_i
  product = Product.find_or_initialize_by(id: product_id)
  product.fullscans_needed = true unless product.persisted?

  obj_map = [
    {key: "name", path: "name", obj_type: "string"},
    {key: "slug", path: "slug", obj_type: "string"},
    {key: "tagline", path: "tagline", obj_type: "string"},
    {key: "followers_count", path: "followers_count", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "posts_count", path: "posts,totalCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "reviews_count", path: "reviews,totalCount", obj_type: "int", get_max: true, fullscans_check: true},
    {key: "reviews_rating", path: "reviews_rating", obj_type: nil},
    {key: "org_created_at", path: "createdAt", obj_type: nil}
  ]

  obj_map.each do |m|
    if v = helper_get_node_by_path(n, m[:path], m[:obj_type])
      old_v = product[ m[:key] ]
      new_v = nil

      if m[:get_max] == true
        new_v = product[ m[:key] ].nil? ? v : [ product[ m[:key] ], v ].max
      else
        new_v = v
      end

      product[ m[:key] ] = new_v

      if m[:fullscans_check] == true && old_v != new_v
        product.fullscans_needed = true
      end

    end
  end

  arr_map = [
    ["topic_ids"],
    ["post_ids"],
    ["reviewers_ids"]
  ]

  arr_map.each do |m|
    product[m[0]] = [] if product[m[0]].nil?
  end

  if edges = helper_get_node_by_path(n, "topics,edges", "array")
    product.topic_ids += edges.collect { |_n| _n["node"]["id"].to_i }
  end

  if edges = helper_get_node_by_path(n, "posts,edges", "array")
    edges.each do |_n|
      _post = helper_get_post_by_node_data(_n["node"])
      _post.product_id = product_id
      _post.save
      product.post_ids.push(_post.id)
    end
  end

  if edges = helper_get_node_by_path(n, "reviews,edges", "array")
    raw_sql = ""
    old_reviewers_ids_count = product.reviewers_ids.count
    edges.each do |_n|
      user_id = _n["node"]["user"]["id"].to_i
      helper_save_user_to_json(_n["node"]["user"])
      # user = helper_get_user_by_node_data(_n["node"]["user"])
      # user.save
      product.reviewers_ids.push(user_id)
      raw_sql += "INSERT INTO product_reviewer (product_id, user_id, created_at) VALUES(#{product_id},#{user_id},'#{_n["node"]["createdAt"]}') ON CONFLICT (product_id, user_id) DO NOTHING;"
    end

    if product.reviewers_ids.uniq.count > old_reviewers_ids_count
      ActiveRecord::Base.connection.execute(raw_sql)
    end
  end

  arr_map.each do |m|
    if product[m[0]]
      product[m[0]] = product[m[0]].uniq.compact.sort
      if product[m[0]].empty?
        product[m[0]] = nil
      end
      if m[1]
         if product[m[0]]
          product[m[1]] = product[m[0]].count
         end
      end
    end
  end

  product.fullscans_needed = nil if product.is_trashed == true
  return product
end
