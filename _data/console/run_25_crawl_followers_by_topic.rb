# Mot lan duoc 100 users
#
#

max_num = 100
cursors = Cursor.where("page%#{max_num}=0").order(:page)

where_str = "followers_count > 120000 and followers_count<605355"

commands = []
Topic.where(where_str).order("followers_count").each do |t|
  cursors[..(t.followers_count/max_num+1)].each_with_index do |cursor, i|
    commands.push "./GetFollowersByTopicLite.sh #{cursor.id} #{t.slug} #{max_num} #{cursor.code}"
  end
end
slipt_commands_to_files(commands, 30)



def import_followers json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      if data["data"]
        if data["data"]["topic"]
          topic_id = data["data"]["topic"]["id"].to_i
          if data["data"]["topic"]["subscribers"]
            if data["data"]["topic"]["subscribers"]["edges"]
              raw_sql = ""
              data["data"]["topic"]["subscribers"]["edges"].each do |e|
                user = helper_get_user_by_node_data(e["node"])
                user.version = 6
                user.save
                raw_sql += "INSERT INTO topic_subscriber (topic_id, user_id) VALUES(#{topic_id},#{user.id}) ON CONFLICT (topic_id, user_id) DO NOTHING;"
              end
              ActiveRecord::Base.connection.execute(raw_sql)
              system "rm #{fn}"
            end
          end
        end
      end
    rescue

    end

  end
end



import_followers "/Users/quang/Downloads/ok/followers-by-topic/"


def recheck_error json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    arr = fn.split("/").last.split(".")
    system "cd _data/scripts/ && ./GetFollowersByTopicLite.sh #{arr[0]} #{arr[1]} #{arr[2]} #{arr[3]}"
  end
end

import_followers "_data/scripts/tmp/followers-by-topic/"

import_followers "/Users/quang/Downloads/ok/followers-by-topic/"


fns = Dir["/Users/quang/Downloads/followers/**/*.json"]
fns.each do |fn|
  arr = fn.split("/").last.split(".")
  id = arr[1].to_i
  code = arr[4]
  Cursor.find_or_create_by(page: id, code: code)
end

