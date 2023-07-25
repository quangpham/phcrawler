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

def helper_get_node_by_path n, path, obj_type = nil
  path_arr = path.kind_of?(Array) ? path : "#{path.to_s}".gsub(" ","").split(",")
  return nil if path_arr.empty?

  if path_arr.count == 1
    v = n[path_arr.first]
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

def helper_get_user_by_node_data u
  user_id = u["id"].to_i

  user = User.find_or_initialize_by(id: user_id)
  user.username = u["username"] if !u["username"].nil? && !u["isTrashed"]

  obj_map = [
    {key: "name", path: "name", obj_type: "string"},
    {key: "headline", path: "headline", obj_type: "string"},
    {key: "website", path: "websiteUrl", obj_type: "string"},
    {key: "twitter", path: "twitterUsername", obj_type: "string"},
    {key: "about", path: "about", obj_type: "string"},
    {key: "org_created_at", path: "createdAt", obj_type: nil},
    {key: "job_title", path: "work,jobTitle", obj_type: "string"},
    {key: "company_name", path: "work,companyName", obj_type: "string"},
    {key: "work_product_id", path: "work,product,id", obj_type: "int"},
    {key: "is_maker", path: "isMaker", obj_type: "bool"},
    {key: "is_trashed", path: "isTrashed", obj_type: "bool"},
    {key: "followers", path: "followersCount", obj_type: "int", get_max: true},
    {key: "following", path: "followingsCount", obj_type: "int", get_max: true},
    {key: "badges", path: "badgesCount", obj_type: "int", get_max: true},
    {key: "products_count", path: "productsCount", obj_type: "int", get_max: true},
    {key: "collections_count", path: "collectionsCount", obj_type: "int", get_max: true},
    {key: "votes_count", path: "votesCount", obj_type: "int", get_max: true},
    {key: "submitted_posts_count", path: "submittedPostsCount", obj_type: "int", get_max: true},
    {key: "stacks_count", path: "stacksCount", obj_type: "int", get_max: true},
    {key: "score", path: "karmaBadge,score", obj_type: "int", get_max: true},
    {key: "activities_count", path: "activityEvents,totalCount", obj_type: "int", get_max: true},
    {key: "max_streak", path: "visitStreak,duration", obj_type: "int", get_max: true}
  ]

  obj_map.each do |m|
    if v = helper_get_node_by_path(u, m[:path], m[:obj_type])
      if m[:get_max] == true
        user[ m[:key] ] = user[ m[:key] ].nil? ? v : [ user[ m[:key] ], v ].max
      else
        user[ m[:key] ] = v
      end
    end
  end

  # INIT
  arr_map = [
    ["followed_topic_ids", "followed_topics_count"],
    ["follower_ids"],
    ["following_ids"],
    ["stack_product_ids"],
    ["submitted_post_ids"],
    ["collection_ids"],
    ["links", "links_count"]
  ]
  arr_map.each do |m|
    user[m[0]] = [] if user[m[0]].nil?
  end

  if edges = helper_get_node_by_path(u, "followedTopics,edges", "array")
    user.followed_topic_ids += edges.collect { |e| e["node"]["id"].to_i }
  end

  if edges = helper_get_node_by_path(u, "followers,edges", "array")
    user.follower_ids += edges.collect { |e| e["node"]["id"].to_i }
  end

  if edges = helper_get_node_by_path(u, "following,edges", "array")
    user.following_ids += edges.collect { |e| e["node"]["id"].to_i }
  end

  if edges = helper_get_node_by_path(u, "submittedPosts,edges", "array")
    user.submitted_post_ids += edges.collect { |e| e["node"]["id"].to_i }
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
      user["#{b["awardKind"]}"]  = b["badgesCount"]
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

  return user
end

# fn = "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp/user-profiles/byosko.json"
# data = JSON.parse(File.read(fn))
# user = helper_get_user_by_node_data(data["data"]["profile"])

def helper_get_post_by_node_data n
  post = Post.find_or_initialize_by(id: n["id"].to_i)

  # post.name = n["name"] if n["name"]
  # post.slug = n["slug"] if n["slug"]
  # post.tagline = n["tagline"] if n["tagline"]
  # post.pricing_type = n["pricingType"] if n["pricingType"]
  # post.comments_count = n["commentsCount"] if n["commentsCount"]
  # post.votes_count = n["votesCount"] if n["votesCount"]
  # post.org_created_at = n["createdAt"] if n["createdAt"]
  # post.org_featured_at = n["featuredAt"] if n["featuredAt"]
  # post.org_updated_at = n["updatedAt"] if n["updatedAt"]

  obj_map = [
    {key: "name", path: "name", obj_type: "string"},
    {key: "slug", path: "slug", obj_type: "string"},
    {key: "tagline", path: "tagline", obj_type: "string"},
    {key: "pricing_type", path: "pricingType", obj_type: "string"},
    {key: "comments_count", path: "commentsCount", obj_type: "int", get_max: true},
    {key: "votes_count", path: "votesCount", obj_type: "int", get_max: true},
    {key: "org_created_at", path: "createdAt", obj_type: nil},
    {key: "org_featured_at", path: "featuredAt", obj_type: nil},
    {key: "org_updated_at", path: "updatedAt", obj_type: nil}
  ]

  obj_map.each do |m|
    if v = helper_get_node_by_path(n, m[:path], m[:obj_type])
      if m[:get_max] == true
        post[ m[:key] ] = post[ m[:key] ].nil? ? v : [ post[ m[:key] ], v ].max
      else
        post[ m[:key] ] = v
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
    unless Product.find_by(id: product_id)
       product_slug = helper_get_node_by_path(n, "product,slug", "string") || helper_get_node_by_path(n, "redirectToProduct,slug", "string")
       Product.create(id: product_id, slug: product_slug)
    end
  end

  # if n["redirectToProduct"]
  #   if n["redirectToProduct"]["id"]
  #     post.product_id = n["redirectToProduct"]["id"].to_i
  #   end
  # end

  # if n["product"]
  #   if n["product"]["id"]
  #     post.product_id = n["product"]["id"].to_i
  #   end
  # end
  #

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

      user = helper_get_user_by_node_data(u)
      user.save
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

  return post
end

def helper_get_product_by_node_data n
  product_id = n["id"].to_i
  product = Product.find_or_initialize_by(id: product_id)

  # product.slug = n["slug"] if n["slug"]
  # product.name = n["name"] if n["name"]
  # product.tagline = n["tagline"] if n["tagline"]
  # product.logo_uuid = n["logoUuid"] if n["logoUuid"]
  # product.followers_count = n["followersCount"] if n["followersCount"]
  # product.reviews_rating = n["reviewsRating"] if n["reviewsRating"]
  # product.org_created_at = n["createdAt"] if n["createdAt"]


  obj_map = [
    {key: "name", path: "name", obj_type: "string"},
    {key: "slug", path: "slug", obj_type: "string"},
    {key: "tagline", path: "tagline", obj_type: "string"},
    {key: "logo_uuid", path: "logoUuid", obj_type: "string"},
    {key: "followers_count", path: "followers_count", obj_type: "int", get_max: true},
    {key: "posts_count", path: "posts,totalCount", obj_type: "int", get_max: true},
    {key: "reviews_count", path: "reviews,totalCount", obj_type: "int", get_max: true},
    {key: "reviews_rating", path: "reviews_rating", obj_type: nil},
    {key: "org_created_at", path: "createdAt", obj_type: nil}
  ]

  obj_map.each do |m|
    if v = helper_get_node_by_path(n, m[:path], m[:obj_type])
      if m[:get_max] == true
        product[ m[:key] ] = product[ m[:key] ].nil? ? v : [ product[ m[:key] ], v ].max
      else
        product[ m[:key] ] = v
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
    edges.each do |_n|
      user = helper_get_user_by_node_data(_n["node"]["user"])
      user.save
      product.reviewers_ids.push(user.id)
      raw_sql += "INSERT INTO product_reviewer (product_id, user_id, created_at) VALUES(#{product_id},#{user.id},'#{_n["node"]["createdAt"]}') ON CONFLICT (product_id, user_id) DO NOTHING;"
    end
    ActiveRecord::Base.connection.execute(raw_sql)
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
      select id,DATE(org_created_at) sys_created_at from posts where org_created_at is not null
    ) t
    group by sys_created_at
  ) t2
  where post_archives.sys_created_at = t2.sys_created_at;
'


update_last_active_at = '

update users t1 set last_active_at=GREATEST(t1.last_active_at, t2.last_active_at)
from (
	select user_id,max(org_created_at) as last_active_at
	from user_collections
	group by user_id
) t2
where t1.id = t2.user_id;

update users t1 set last_active_at=GREATEST(t1.last_active_at, t2.last_active_at)
from (
	select user_id,max(created_at) as last_active_at
	from product_reviewer
	group by user_id
) t2
where t1.id = t2.user_id;

'
