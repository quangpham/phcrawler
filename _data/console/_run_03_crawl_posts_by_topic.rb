# Buoc 3
# Tao file crawl posts theo topic
# Chi can tao cho topic parent la duoc
# Crawl luon upvoters (max 200) | Thang nao >200, thi crawl post detail de lay upvoters
# Crawl upn topic_ids cua post
# Khong product_id, created_at, featured_at, pricing_type, rating, tagline, topics_count
# Nho them version cho posts, va thay version cho users
# Split files de chay tren server


# Tao it files
# commands = []

# max_posts = 400
# Topic.where("parent_id is null").each do |t|
#   cursors[..(max_posts/20+2)].each_with_index do |cursor, i|
#     commands.push "./GetPostsByTopic.sh #{1000+i} #{t.slug} #{cursor}"
#   end
# end

# max_posts = 100
# Topic.where("parent_id is not null").each do |t|
#   cursors[..(max_posts/20+2)].each_with_index do |cursor, i|
#     commands.push "./GetPostsByTopic.sh #{1000+i} #{t.slug} #{cursor}"
#   end
# end

# slipt_commands_to_files(commands, 15, cursors)



max_num = 20
cursors = Cursor.where("page%#{max_num}=0").order(:page)

commands = []
Topic.order(:posts_count).each do |t|
  cursors[..(t.posts_count/max_num+1)].each_with_index do |cursor, i|
    commands.push "./GetPostsByTopic.sh #{cursor.page} #{t.slug} #{cursor.code}"
  end
end
slipt_commands_to_files(commands, 30)


# Buoc 4
# Sync results posts-by-topic
# Tao/Update posts moi
# Tao/Upbase users moi

def post_version obj
  version = ""
  if obj.id.nil?
    version = "new-by-topic"
  else
    version = "topic-02|#{obj.version}"
  end
  return version.gsub(" ","").split("|").uniq.join("|")
end


def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].sort.each do |fn|
    begin
      data = JSON.parse(File.read(fn))

      data["data"]["topic"]["posts"]["edges"].each do |p|
        post = helper_get_post_by_node_data(p["node"])
        post.version = post_version(post)
        post.save
      end

      if data["data"]["topic"]["posts"]["edges"].count > 0
        system "rm #{fn}"
      end

    rescue
      next
    end
  end
end


import_posts "/Users/quang/Downloads/ok/posts-by-topic"
