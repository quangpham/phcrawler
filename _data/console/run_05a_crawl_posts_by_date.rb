# Buoc 5
# Tao file Crawl posts theo date (archive)
# Muc dich
# - crawl them posts (max 20)
# - Luu lai posts_count theo ngay

# Notes:
# - Moi lan crawl duoc 20 posts/lan
#
# Extra:
# - Tinh toan de lam phien ban lite, contributor it hon

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
  version = ""
  if obj.id.nil?
    version = "new-by-archive"
  else
    version = "arc-02|#{obj.version}"
  end
  return version.gsub(" ","").split("|").uniq.join("|")
end

def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/*.json".gsub("//","/")].sort.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      posts_data = data["data"]["posts"]
      edges_count = posts_data["edges"].count

      if edges_count > 0
        a = PostArchive.find_or_initialize_by(sys_created_at: posts_data["edges"][0]["node"]["createdAt"])
        a.posts_count = posts_data["totalCount"]
        a.save

        posts_data["edges"].each do |p|
          post = helper_get_post_by_node_data(p["node"])
          post.version = post_version(post)
          post.save
        end

        system "rm #{fn}"
      end

    rescue
      next
    end
  end
end


## CRAWL NHUNG NGAY VUA ROI
(1..365).to_a.reverse.to_a.each do |i|
  if PostArchive.find_by(sys_created_at: i.days.ago).nil?
    a = PostArchive.create(sys_created_at: i.days.ago)
    system "cd _data/scripts/ && ./GetPostsByDateR.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i}"
  end
end
import_posts "_data/scripts/tmp/posts-by-date/"

(1..30).to_a.reverse.to_a.each do |i|
  if a = PostArchive.find_by(sys_created_at: i.days.ago)
    system "cd _data/scripts/ && ./GetPostsByDateR.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i}"
  end
end
import_posts "_data/scripts/tmp/posts-by-date/"




import_posts "_data/scripts/tmp/posts-by-date/"

# import_posts "/Users/quang/Downloads/done_5"
