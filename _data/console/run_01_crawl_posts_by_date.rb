# Buoc 51
# Tao file Crawl posts theo date (archive)
# Muc dich
# - crawl them posts (max 20)

# Extra:
# - Tinh toan de lam phien ban lite, contributor it hon

# Tao lenh crawl toan bo post trong 60 ngay vua qua

commands = []
(1..60).to_a.reverse.to_a.each do |i|
  if a = PostArchive.find_or_create_by(sys_created_at: i.days.ago)
    # system "cd _data/scripts/ && ./GetPostsByDateR.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i}"
    commands.push "./GetPostsByDateR.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i}"
  end
end
slipt_commands_to_files(commands, 10)

###
def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].sort.each do |fn|
    data = JSON.parse(File.read(fn))
    posts_data = data["data"]["posts"]
    edges_count = posts_data["edges"].count

    if edges_count > 0
      a = PostArchive.find_or_initialize_by(sys_created_at: posts_data["edges"][0]["node"]["createdAt"])
      a.posts_count = posts_data["totalCount"]
      a.save
      posts_data["edges"].each do |p|
        post = helper_get_post_by_node_data(p["node"])
        post.save
      end

      system "rm #{fn}"
    end

  end
end

import_posts "/Users/quang/Downloads/ok/posts-by-date/"
import_posts "_data/scripts/tmp/posts-by-date/"