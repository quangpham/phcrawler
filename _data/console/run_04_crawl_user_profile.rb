# scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@159.89.192.33:/root/a.zip
# ssh root@159.89.192.33 'cd /root/ && rm -rf run* && unzip a.zip'

# ssh root@159.89.192.33 'ls -1 run/tmp/user-profiles/ | wc -l'

# ssh root@159.89.192.33 "cd /root/run/ && mkdir done_04_a && find tmp/user-profiles/ -name '*.json' -exec mv -t done_04_a/ {} + && zip -r done_04_a.zip done_04_a/"
# scp root@159.89.192.33:/root/run/done_04_a.zip /Users/quang/Downloads/ok/user-profiles/


commands = []
usernames = []
usernames += User.where("fullscans_needed=true and (is_trashed is null or is_trashed=false)").select(:id, :username).collect {|p| p.username}
usernames.uniq.sort.each do |username|
  commands.push "./GetUserProfile.sh #{username}"
end

slipt_commands_to_files(commands, 15)



def import_profiles json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    data = JSON.parse(File.read(fn))
    if data["data"]
      if data["data"]["profile"]
        user = helper_get_user_by_node_data(data["data"]["profile"])
        user.fullscans_needed = nil if user.fullscans_needed == true
        user.save
        system "rm #{fn}"
        User.where("username=? and id!=?", user.username, user.id).update_all(is_trashed: true, fullscans_needed: nil)
      else
        un = fn.split("/").last.split(".json").first
        if user = User.find_by(username: un)
          user.is_trashed = true
          user.fullscans_needed = nil
          user.save
          system "rm #{fn}"
        end
      end
    end
  end
end


import_profiles "/Users/quang/Downloads/ok/user-profiles"




