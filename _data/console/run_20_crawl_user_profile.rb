commands = []
# where_str = "badges > 0 and score > 1 and version!=2"
# where_str = "version!=2 and followers > 10"
# where_str =  "(version!=2 or version is null) and (followers > 50 or badges > 1 or score > 1 or is_maker=true)"
where_str = "followers > 50 or badges > 1 or score > 1 or is_maker=true or version=2 or version=3 or version=4"
where_str = "(followers > 3 or badges > 1 or score > 1 or is_maker=true) and (version!=5 or version is null) and (is_trashed is null or is_trashed=false)"
where_str = "is_trashed is null"
User.where(where_str).select(:id, :username, :is_trashed).each do |u|
  if u.is_trashed == false || u.is_trashed.nil?
    commands.push "./GetUserProfile.sh #{u.username}"
  end
end
slipt_commands_to_files(commands, 30)




def import_profiles json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/_r.*.json".gsub("//","/")].shuffle.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      if data["data"]
        if data["data"]["profile"]
          user = helper_get_user_by_node_data(data["data"]["profile"])
          user.version = 5
          user.save
        else
          username = fn.split("/").last.gsub("_r.profile.","").gsub(".json","")
          if user = User.find_by(username: username)
            user.update(is_trashed: true)
          end
        end
        system "rm #{fn}"
      end
    rescue
    end
  end
end


import_profiles "/Users/quang/Downloads/users"

import_profiles "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp"
import_profiles "/Users/quang/Projects/upbase/phcrawler/tmp/run/tmp"
import_profiles "/Users/quang/Downloads/done_3"


