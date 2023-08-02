scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@209.97.164.48:/root/a.zip
ssh root@209.97.164.48 'cd /root/ && rm -rf run* && unzip a.zip'

scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@159.223.55.78:/root/a.zip
ssh root@159.223.55.78 'cd /root/ && rm -rf run* && unzip a.zip'

scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@139.59.101.195:/root/a.zip
ssh root@139.59.101.195 'cd /root/ && rm -rf run* && unzip a.zip'




ssh root@209.97.164.48 'ls -1 run/tmp/user-profiles/ | wc -l'
ssh root@159.223.55.78 'ls -1 run/tmp/user-profiles/ | wc -l'
ssh root@139.59.101.195 'ls -1 run/tmp/user-profiles/ | wc -l'

ssh root@209.97.164.48 "cd /root/run/ && rm -rf done* && mkdir done_16_a && find tmp/user-profiles/ -name '*.json' -exec mv -t done_16_a/ {} + && zip -r done_16_a.zip done_16_a/"
scp root@209.97.164.48:/root/run/done_16_a.zip /Users/quang/Downloads/ok/user-profiles/

ssh root@159.223.55.78 "cd /root/run/ && rm -rf done* && mkdir done_16_b && find tmp/user-profiles/ -name '*.json' -exec mv -t done_16_b/ {} + && zip -r done_16_b.zip done_16_b/"
scp root@159.223.55.78:/root/run/done_16_b.zip /Users/quang/Downloads/ok/user-profiles/

ssh root@139.59.101.195 "cd /root/run/ && rm -rf done* && mkdir done_16_c && find tmp/user-profiles/ -name '*.json' -exec mv -t done_16_c/ {} + && zip -r done_16_c.zip done_16_c/"
scp root@139.59.101.195:/root/run/done_16_c.zip /Users/quang/Downloads/ok/user-profiles/




commands = []
usernames = []
# usernames += User.where("fullscans_needed=true and (is_trashed is null or is_trashed=false)").select(:id, :username).collect {|p| p.username}
# usernames += User.where("(is_trashed is null or is_trashed=false)").select(:id, :username).collect {|p| p.username}
usernames += User.where("fullscans_needed=false").select(:id, :username).collect {|p| p.username}
usernames.uniq.sort.each do |username|
  commands.push "./GetUserProfile.sh #{username}"
end

slipt_commands_to_files(commands, 45)



def import_profiles json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    next if !(File.exist?(fn) && !File.zero?(fn))
    data = parse_json(File.read(fn))
    next if data.nil?
    if data["data"]
      if data["data"]["profile"]
        user = helper_get_user_by_node_data(data["data"]["profile"])
        # user.fullscans_needed = nil if user.fullscans_needed == true
        user.fullscans_needed = nil if !user.fullscans_needed.nil?
        user.save
        system "rm #{fn}"
        # User.where("username=? and id!=?", user.username, user.id).update_all(is_trashed: true, fullscans_needed: nil)
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




