commands = []
User.where("badges > 0 and score > 1 and version!=2").select(:id, :username, :is_trashed).each do |u|
  if u.is_trashed == false || u.is_trashed.nil?
    commands.push "./GetUserProfile.sh #{u.username}"
  end
end
slipt_commands_to_files(commands, 30, cursors)




def import_profiles json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/_r.*.json".gsub("//","/")].shuffle.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      if data["data"]
        if data["data"]["profile"]
          user = helper_get_user_by_node_data(data["data"]["profile"])
          user.version = 2
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

import_profiles "/Users/quang/Projects/upbase/phcrawler/tmp/run/tmp"
import_profiles "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp"
import_profiles "/Users/quang/Downloads/done_3"


