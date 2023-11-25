# Buoc 51
# Tao file Crawl posts theo date (archive)
# Muc dich
# - crawl them posts (max 20)

# Extra:
# - Tinh toan de lam phien ban lite, contributor it hon

# Tao lenh crawl toan bo post trong 60 ngay vua qua


scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@157.245.200.108:/root/a.zip
ssh root@157.245.200.108 'cd /root/ && rm -rf run* && unzip a.zip && cd /root/run/ && ./run.sh &'

ssh root@157.245.200.108 'ls -1 run/tmp/posts-by-date/ | wc -l'

mkdir -p /Users/quang/Downloads/ok/posts-by-date/
now=$(date +%H%M%S) && ssh root@157.245.200.108 "cd /root/run/ && mkdir done_$now && find tmp/posts-by-date/ -name '*.json' -exec mv -t done_$now/ {} + && zip -r done_$now.zip done_$now/"
scp root@157.245.200.108:/root/run/done_$now.zip /Users/quang/Downloads/ok/posts-by-date/



commands = []
(1..30).to_a.reverse.to_a.each do |i|
  if a = PostArchive.find_or_create_by(sys_created_at: i.days.ago)
    if a.week_day.nil?
      a.update(week_day: a.sys_created_at.strftime('%^a'))
    end
    # system "cd _data/scripts/ && ./GetPostsByDateR.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i}"
    commands.push "./GetPostsByDateR.sh #{a.sys_created_at.year.to_i} #{a.sys_created_at.month.to_i} #{a.sys_created_at.day.to_i}"
  end
end
slipt_commands_to_files(commands, 15)

###
def import_posts_by_date json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    next if !(File.exist?(fn) && !File.zero?(fn))
    data = parse_json(File.read(fn))
    next if data.nil?

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

100.times {
  begin
    import_posts_by_date "/Users/quang/Downloads/ok/posts-by-date/"
  rescue
  end
}

import_posts_by_date "tmp/run/tmp/posts-by-date/"

import_posts_by_date "_data/scripts/tmp/posts-by-date/"
