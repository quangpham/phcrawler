# Mot lan duoc 100 users
#
#


scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@174.138.27.130:/root/a.zip
ssh root@174.138.27.130 'cd /root/ && rm -rf run* && unzip a.zip'

ssh root@174.138.27.130 'ls -1 run/tmp/followers-by-topic/ | wc -l'

mkdir -p /Users/quang/Downloads/ok/followers-by-topic/
ssh root@174.138.27.130 "cd /root/run/ && mkdir done_03_a && find tmp/followers-by-topic/ -name '*.json' -exec mv -t done_03_a/ {} + && zip -r done_03_a.zip done_03_a/"
scp root@174.138.27.130:/root/run/done_03_a.zip /Users/quang/Downloads/ok/followers-by-topic/

commands = []
Topic.all.order("followers_count").each do |t|
  commands.push "./GetFollowersByTopicLite.sh 0 #{t.slug} 10"
end
slipt_commands_to_files(commands, 15)

##
max_num = 100
max_followers_to_crawl = 10000
cursors = Cursor.where("page%#{max_num}=0").order(:page)
Topic.where("followers_count is not null").order("followers_count").each do |t|
  max = t.followers_count < max_followers_to_crawl ? t.followers_count : max_followers_to_crawl
  cursors[..(max/max_num+1)].each_with_index do |cursor, i|
    commands.push "./GetFollowersByTopicLite.sh #{cursor.id} #{t.slug} #{max_num} #{cursor.code}"
  end
end

##

max_num = 100
cursors = Cursor.where("page%#{max_num}=0").order(:page)

where_str = "followers_count > 120000 and followers_count<605355"

commands = []
Topic.where(where_str).order("followers_count").each do |t|
  cursors[..(t.followers_count/max_num+1)].each_with_index do |cursor, i|
    commands.push "./GetFollowersByTopicLite.sh #{cursor.id} #{t.slug} #{max_num} #{cursor.code}"
  end
end
slipt_commands_to_files(commands, 15)



def import_followers json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    next if !(File.exist?(fn) && !File.zero?(fn))
    data = parse_json(File.read(fn))
    next if data.nil?

    if topic_id = helper_get_node_by_path(data, "data,topic,id", "int")
      if topic = Topic.find_by(id: topic_id)
        # topic.posts_count =
        topic.products_count = helper_get_node_by_path(data, "data,topic,products,totalCount", "int")
        topic.followers_count = helper_get_node_by_path(data, "data,topic,subscribers,totalCount", "int")
        topic.save
        if edges = helper_get_node_by_path(data, "data,topic,subscribers,edges", "array")
          raw_sql = ""
          edges.each do |e|
            user = helper_get_user_by_node_data(e["node"])
            user.save
            raw_sql += "INSERT INTO topic_subscriber (topic_id, user_id) VALUES(#{topic_id},#{user.id}) ON CONFLICT (topic_id, user_id) DO NOTHING;"
          end
          ActiveRecord::Base.connection.execute(raw_sql)
          system "rm #{fn}"
        end
      end
    end

  end
end



import_followers "/Users/quang/Downloads/ok/followers-by-topic/"
import_followers "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp/"


def recheck_error json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    arr = fn.split("/").last.split(".")
    system "cd _data/scripts/ && ./GetFollowersByTopicLite.sh #{arr[0]} #{arr[1]} #{arr[2]} #{arr[3]}"
  end
end

import_followers "_data/scripts/tmp/followers-by-topic/"

import_followers "/Users/quang/Downloads/ok/followers-by-topic/"


fns = Dir["/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp/**/*.json"]
fns.each do |fn|
  arr = fn.split("/").last.split(".")
  id = arr[1].to_i
  code = arr[4]
  Cursor.find_or_create_by(page: id, code: code)
end
