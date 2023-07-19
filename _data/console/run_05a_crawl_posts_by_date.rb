# Buoc 5
# Tao file Crawl posts theo date (archive)
# Muc dich
# - crawl them posts (max 20)
# - Luu lai posts_count theo ngay
# Notes:
# - Moi lan crawl duoc 20 posts/lan

### Tinh toan posts_count cho tung ngay
commands = []
PostArchive.select(:id, :sys_created_at).order(:id).each do |a|
  commands.push "./GetPostsByDate.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i}"
end
slipt_commands_to_files(commands, 15, cursors)

####
commands = []
PostArchive.where("posts_count > 19").each do |a|
  cursors[..(a.posts_count/20+2)].each_with_index do |cursor, i|
    commands.push "./GetPostsByDate.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i} #{cursor}"
  end
end
slipt_commands_to_files(commands, 15, cursors)



# Import posts and archive data
def post_version obj
  return obj.id.nil? ? "new" : "p_p_1"
end

def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      posts_data = data["data"]["posts"]
      edges_count = posts_data["edges"].count

      if edges_count > 0
        a = PostArchive.find_or_initialize_by(sys_created_at: posts_data["edges"][0]["node"]["createdAt"])
        a.posts_count = posts_data["totalCount"]
        a.save

        posts_data["edges"].each do |p|
          n = p["node"]
          post_id = n["id"].to_i
          post = Post.find_or_initialize_by(id: post_id)
          post.name = n["name"]
          post.slug = n["slug"]
          post.tagline = n["tagline"]
          post.pricing_type = n["pricingType"]
          post.comments_count = n["commentsCount"]
          post.votes_count = n["votesCount"]
          post.s_created_at = n["createdAt"]
          post.s_featured_at = n["featuredAt"]
          post.s_updated_at = n["updatedAt"]

          if n["topics"]
            post.topic_ids = ([post.topic_ids] + []).flatten.compact
            n["topics"]["edges"].each do |t|
              post.topic_ids.push(t["node"]["id"].to_i)
            end
            post.topic_ids = post.topic_ids.uniq.compact.sort
            post.topic_ids = nil if post.topic_ids.empty?
          end

          post.save
        end

        system "rm #{fn}"
      end

    rescue
      next
    end
  end
end

# import_posts "/Users/quang/Downloads/done_5"
