# Buoc 2
# CRAWL & IMPORT TOPICS
# Muc dich
# - xem con co topics moi ko
# - update followers_count, recent_stacks_count
# - update real_posts_count -> Cai nay moi dung, vi no lay trong database ra. Trong khi posts_count co the la duoc cache (hoac tinh luon inactive)


# SQL QUERY
# update topics set old_followers_count=followers_count, old_products_count=products_count, old_real_posts_count=real_posts_count;
# update topics set followers_count=null, products_count=null, real_posts_count=null;

###

def topic_version obj
    return obj.id.nil? ? 0 : 4
end


system "_data/Topic.sh"

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

