# Mot lan duoc 100 users
#
#

where_str = "parent_id is null and followers_count is not null"
commands = []
Topic.where(where_str).order("followers_count").each do |t|
  commands.push "./GetFollowersByTopicR.sh 0 #{t.slug} 100"
end
slipt_commands_to_files(commands, 10, cursors)




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

import_followers "/Users/quang/Downloads/followers"

fns = Dir["/Users/quang/Downloads/followers/**/*.json"]
fns.each do |fn|
  arr = fn.split("/").last.split(".")
  id = arr[1].to_i
  code = arr[4]
  Cursor.create(id: id, code: code)
end

