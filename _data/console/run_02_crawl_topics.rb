# Buoc 2
# CRAWL & IMPORT TOPICS
# Muc dich
# - xem con co topics moi ko
# - update followers_count, recent_stacks_count
# - update real_posts_count -> Cai nay moi dung, vi no lay trong database ra. Trong khi posts_count co the la duoc cache (hoac tinh luon inactive)


# SQL QUERY
sql = '
  update topics set old_followers_count=followers_count, old_products_count=products_count, old_real_posts_count=real_posts_count;
  update topics set followers_count=null, products_count=null, real_posts_count=null;
'


###

def topic_version obj
    return obj.id.nil? ? 0 : 5
end


system "_data/GetTopics.sh"

fn = "tmp/topics.json"
data = JSON.parse(File.read(fn))

data["data"]["topics"]["edges"].each do |n|
  t = n["node"]
  topic = Topic.find_or_initialize_by(id: t["id"].to_i)
  topic.name = t["name"]
  topic.slug = t["slug"]
  topic.followers_count = t["followersCount"]
  topic.posts_count = t["postsCount"]
  if t["parent"]
    parent = Topic.find_or_create_by(id: t["parent"]["id"].to_i)
    topic.parent_id = parent.id
  end
  if t["posts"]
    topic.real_posts_count = t["posts"]["totalCount"]
  end
  if t["products"]
    topic.products_count =t["products"]["totalCount"]
  end
  if t["recentStacks"]
    topic.recent_stacks_count =t["recentStacks"]["totalCount"]
  end
  topic.version = topic_version(topic)
  topic.save
end




# Get catergory
#
#

system "_data/scripts/GetCategories.sh"

def helper_get_category_by_node_data n
  c = Category.find_or_initialize_by(id: n["id"].to_i)

  if n["path"]
    c.path = n["path"].gsub("/categories/","")
  end

  if n["products"]
    if n["products"]["totalCount"]
      c.products_count = n["products"]["totalCount"].to_i
    end
  end

  if n["parent"]
    if n["parent"]["id"]
      c.parent_id = n["parent"]["id"].to_i
    end
  end

  if n["subCategories"]
    if n["subCategories"]["totalCount"]
      c.subs_count = n["subCategories"]["totalCount"].to_i
    end
    c.sub_ids = [] if c.sub_ids.nil?
    c.sub_ids += n["subCategories"]["edges"].collect {|_e| _e["node"]["id"].to_i}
    c.sub_ids = c.sub_ids.uniq.compact.sort
    c.sub_ids = nil if c.sub_ids.empty?

    n["subCategories"]["edges"].each {|_e| helper_get_category_by_node_data(_e["node"]).save }
  end

  return c
end

["tmp/_.r_categories.first.json","tmp/_.r_categories.last.json"].each do |fn|
  data = JSON.parse(File.read(fn))

  data["data"]["productCategories"]["edges"].each do |e|
    c =helper_get_category_by_node_data(e["node"]).save
  end
end
