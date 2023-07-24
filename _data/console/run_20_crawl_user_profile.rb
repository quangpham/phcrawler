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




# def user_version obj
#   version = ""
#   if obj.id.nil?
#     version = "new-by-voters"
#   else
#     version = "voters-04|#{obj.version}"
#   end
#   return version.gsub(" ","").split("|").uniq.join("|")
# end

def import_profiles json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      if data["data"]
        if data["data"]["profile"]
          user = helper_get_user_by_node_data(data["data"]["profile"])
          user.versions = user.versions.nil? ? [0] : ([0] + user.versions).uniq
          user.save
          system "rm #{fn}"
        else
          un = fn.split("/").last.split(".json").first
          if user = User.find_by(username: un)
            user.is_trashed = true
            user.save
            system "rm #{fn}"
          end
        end
      end
    rescue
    end

  end
end


import_profiles "/Users/quang/Downloads/ok/user-profiles"




