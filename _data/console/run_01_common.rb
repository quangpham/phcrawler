# Buoc 1
# Init tmp

def init_tmp
  system "mkdir -p tmp/run/ && rm -R tmp/run/ && mkdir -p tmp/run/"
  system "cp _data/scripts/*.sh tmp/run/"
  system "touch tmp/run/run.sh && chmod u+x tmp/run/run.sh"
end

cursors = File.read("_data/cursors.txt").split(",")

def slipt_commands_to_files commands, number_split_files = 15, cursors
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

def helper_get_user_collection_by_node_data n
  c = UserCollection.find_or_initialize_by(id: n["id"].to_i)
  c.name = n["name"]
  c.title = n["title"]
  c.description = n["description"]
  c.path = n["path"]
  c.products_count = n["productsCount"].to_i
  c.s_created_at = n["createdAt"]

  if n["products"]
    if n["products"]["edges"]
      c.product_ids = n["products"]["edges"].collect { |e| e["node"]["id"].to_i }
    end
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

def helper_get_user_by_node_data u
  user_id = u["id"].to_i

  user = User.find_or_initialize_by(id: user_id)
  user.username = u["username"] if !u["username"].nil? && !u["isTrashed"]

  string_map = [
    ["name","name"],
    ["headline","headline"],
    ["website","websiteUrl"],
    ["twitter","twitterUsername"],
    ["about","about"],
    ["s_created_at","createdAt"]
  ]
  string_map.each do |m|
    user[m[0]] = u[m[1]] if !u[m[1]].nil?
  end

  bool_map = [
    ["is_maker","isMaker"],
    ["is_trashed","is_trashed"]
  ]
  bool_map.each do |m|
    user[m[0]] = u[m[1]] if !u[m[1]].nil?
    user[m[0]] = nil if user[m[0]] == false
  end

  int_map = [
    ["followers","followersCount"],
    ["following","followingsCount"],
    ["badges","badgesCount"],
    ["products_count","productsCount"],
    ["collections_count","collectionsCount"],
    ["votes_count","votesCount"],
    ["submitted_posts_count","submittedPostsCount"],
    ["stacks_count","stacksCount"]
  ]
  int_map.each do |m|
    user[m[0]] = u[m[1]].to_i if !u[m[1]].nil?
    user[m[0]] = nil if user[m[0]] == 0
  end

  arr_map = ["followed_topic_ids", "stack_product_ids", "submitted_post_ids", "collection_ids", "links"]
  arr_map.each do |m|
    user[m] = [] if user[m].nil?
  end

  if u["karmaBadge"]
     if u["karmaBadge"]["score"]
      user.score = u["karmaBadge"]["score"]
     end
  end

  if u["visitStreak"]
    if u["visitStreak"]["duration"]
      user.max_streak = [user.max_streak.to_i, u["visitStreak"]["duration"].to_i].max
      user.max_streak = nil if user.max_streak == 0
    end
  end

  if u["work"]
    if u["work"]["jobTitle"]
      user.job_title =  u["work"]["jobTitle"]
      user.company_name = u["work"]["companyName"]
      if u["work"]["product"]
        user.work_product_id = u["work"]["product"]["id"].to_i
      end
    end
  end

  if u["followedTopics"]
    if u["followedTopics"]["edges"]
      user.followed_topic_ids += u["followedTopics"]["edges"].collect { |e| e["node"]["id"].to_i }
    end
  end

  if u["stacks"]
    if u["stacks"]["edges"]
      user.stack_product_ids += u["stacks"]["edges"].collect { |e| e["node"]["product"]["id"].to_i }
    end
  end

  # submittedPosts
  if u["submittedPosts"]
    if u["submittedPosts"]["edges"]
      user.submitted_post_ids += u["submittedPosts"]["edges"].collect { |e| e["node"]["id"].to_i }
    end
  end

  # collections
  if u["collections"]
    if u["collections"]["edges"]
      u["collections"]["edges"].each do |ce|
        c = helper_get_user_collection_by_node_data(ce["node"])
        c.user_id = user_id
        c.save
        user.collection_ids.push(c.id)
      end
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
      user["#{b["awardKind"]}"]  = b["badgesCount"]
    end
  end

  arr_map.each do |m|
    if user[m]
      user[m] = user[m].uniq.compact.sort
      if user[m].empty?
        user[m] = nil
      end
    end
  end

  return user
end

def helper_get_post_by_node_data n
  post = Post.find_or_initialize_by(id: n["id"].to_i)

  post.name = n["name"] if n["name"]
  post.slug = n["slug"] if n["slug"]
  post.tagline = n["tagline"] if n["tagline"]
  post.pricing_type = n["pricingType"] if n["pricingType"]
  post.comments_count = n["commentsCount"] if n["commentsCount"]
  post.votes_count = n["votesCount"] if n["votesCount"]
  post.s_created_at = n["createdAt"] if n["createdAt"]
  post.s_featured_at = n["featuredAt"] if n["featuredAt"]
  post.s_updated_at = n["updatedAt"] if n["updatedAt"]

  if n["redirectToProduct"]
    if n["redirectToProduct"]["id"]
      post.product_id = n["redirectToProduct"]["id"].to_i
    end
  end

  if n["topics"]
    if n["topics"]["edges"]
      if n["topics"]["edges"].count > 0
        post.topic_ids = [] if post.topic_ids.nil?
        n["topics"]["edges"].each do |_n|
          post.topic_ids.push(_n["node"]["id"].to_i)
        end
        post.topic_ids = post.topic_ids.uniq.compact.sort
        post.topic_ids = nil if post.topic_ids.empty?
      end
    end
  end

  post.hunter_ids = [] if post.hunter_ids.nil?
  post.maker_ids = [] if post.maker_ids.nil?
  post.commenter_ids = [] if post.commenter_ids.nil?
  post.upvoter_ids = [] if post.upvoter_ids.nil?

  if n["contributors"]
    if n["contributors"].count > 0
      n["contributors"].each do |_n|
        u = _n["user"]
        user_id = u["id"].to_i
        post.hunter_ids.push(user_id) if !_n["role"].index("hunter").nil?
        post.maker_ids.push(user_id) if !_n["role"].index("maker").nil?
        post.commenter_ids.push(user_id) if !_n["role"].index("commenter").nil?
        post.upvoter_ids.push(user_id) if !_n["role"].index("upvoter").nil?

        user = helper_get_user_by_node_data(u)
        user.save
      end
    end
  end

  post.hunter_ids = post.hunter_ids.uniq.compact.sort
  post.hunter_ids = nil if post.hunter_ids.empty?
  post.maker_ids = post.maker_ids.uniq.compact.sort
  post.maker_ids = nil if post.maker_ids.empty?
  post.commenter_ids = post.commenter_ids.uniq.compact.sort
  post.commenter_ids = nil if post.commenter_ids.empty?
  post.upvoter_ids = post.upvoter_ids.uniq.compact.sort
  post.upvoter_ids = nil if post.upvoter_ids.empty?

  return post
end

def helper_get_product_by_node_data n
  product_id = n["id"].to_i
  product = Product.find_or_initialize_by(id: product_id)

  product.slug = n["slug"] if n["slug"]
  product.name = n["name"] if n["name"]
  product.tagline = n["tagline"] if n["tagline"]
  product.logo_uuid = n["logoUuid"] if n["logoUuid"]

  product.followers_count = n["followersCount"] if n["followersCount"]
  product.reviews_rating = n["reviewsRating"] if n["reviewsRating"]
  product.s_created_at = n["createdAt"] if n["createdAt"]

  if n["topics"]
    if n["topics"]["edges"].count > 0
      product.topic_ids = [] if product.topic_ids.nil?
      n["topics"]["edges"].each do |t|
        product.topic_ids.push(t["node"]["id"].to_i)
      end
      product.topic_ids = product.topic_ids.uniq.compact.sort
      product.topic_ids = nil if product.topic_ids.empty?
    end
  end

  if n["posts"]
    edges_count = n["posts"]["edges"].count
    product.posts_count = n["posts"]["totalCount"]
    # if product.posts_count > edges_count
    #   product.note = "#{product.note}|p #{edges_count}-#{product.posts_count}"
    # end
    if edges_count > 0
      product.post_ids = [] if product.post_ids.nil?
      n["posts"]["edges"].each do |t|
        ppost = helper_get_post_by_node_data(t["node"])
        ppost.product_id = product_id
        ppost.save
        product.post_ids.push(ppost.id)
      end
      product.post_ids = product.post_ids.uniq.compact.sort
      product.post_ids = nil if product.post_ids.empty?
    end
  end

  if n["reviews"]
    edges_count = n["reviews"]["edges"].count
    product.reviews_count = n["reviews"]["totalCount"]
    # if product.reviews_count > edges_count
    #   product.note = "#{product.note}|r #{edges_count}-#{product.reviews_count}"
    # end
    if edges_count > 0
      raw_sql = ""
      product.reviewers_ids = [] if product.reviewers_ids.nil?
      n["reviews"]["edges"].each do |r|
        user = helper_get_user_by_node_data(r["node"]["user"])
        user.save
        product.reviewers_ids.push(user.id)
        raw_sql += "INSERT INTO product_reviewer (product_id, user_id, created_at) VALUES(#{product_id},#{user.id},'#{r["node"]["createdAt"]}') ON CONFLICT (product_id, user_id) DO NOTHING;"
      end
      product.reviewers_ids = product.reviewers_ids.uniq.compact
      product.reviewers_ids = nil if product.reviewers_ids.empty?
      ActiveRecord::Base.connection.execute(raw_sql)
    end
  end

  return product

end


sql = '

  insert into post_hunter(post_id, user_id)
  select id, unnest(hunter_ids) as user_id from posts where hunter_ids is not null and hunter_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_maker(post_id, user_id)
  select id, unnest(maker_ids) as user_id from posts where maker_ids is not null and maker_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_upvoter(post_id, user_id)
  select id, unnest(upvoter_ids) as user_id from posts where upvoter_ids is not null and upvoter_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_commenter(post_id, user_id)
  select id, unnest(commenter_ids) as user_id from posts where commenter_ids is not null and commenter_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_topic(post_id, topic_id)
  select id,unnest(topic_ids) as topic_id from posts where topic_ids is not null and topic_ids != '{}'
  ON CONFLICT (post_id, topic_id) DO NOTHING;

  insert into product_topic(product_id, topic_id)
  select id,unnest(topic_ids) as topic_id from products where topic_ids is not null and topic_ids != '{}'
  ON CONFLICT (product_id, topic_id) DO NOTHING;

  insert into product_post(product_id, post_id)
  select id,unnest(post_ids) as post_id from products where post_ids is not null and post_ids != '{}'
  ON CONFLICT (product_id, post_id) DO NOTHING;

  # insert into product_reviewer(product_id, user_id)
  # select id,unnest(reviewers_ids) as user_id from products where reviewers_ids is not null and reviewers_ids != '{}'
  # ON CONFLICT (product_id, user_id) DO NOTHING;




  update products p set sys_posts_count=t.posts_count
  from (
    select product_id,count(id) as posts_count from posts
    group by product_id
  ) t
  where p.id = t.product_id;

  update products p set sys_reviews_count=t.reviews_count
  from (
      select product_id,count(user_id) as reviews_count from product_reviewer
      group by product_id
  ) t
  where p.id = t.product_id;

  update posts p set sys_votes_count=t.votes_count
  from (
      select post_id,count(user_id) as votes_count from post_upvoter
      group by post_id
  ) t
  where p.id = t.post_id;

  update topics tp set sys_posts_count=t.posts_count
  from (
      select topic_id,count(post_id) as posts_count from post_topic
      group by topic_id
  ) t
  where tp.id = t.topic_id;

  --- update sys_posts_count cho post_archives
  update post_archives set sys_posts_count=t2.posts_count, post_ids=t2.post_ids
  from (
    select sys_created_at,count(id) as posts_count, ARRAY_AGG(id) as post_ids from (
      select id,DATE(s_created_at) sys_created_at from posts where s_created_at is not null
    ) t
    group by sys_created_at
  ) t2
  where post_archives.sys_created_at = t2.sys_created_at;
'
