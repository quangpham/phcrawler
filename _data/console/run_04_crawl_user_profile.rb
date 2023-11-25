scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@157.245.200.108:/root/a.zip
ssh root@157.245.200.108 'cd /root/ && rm -rf run* && unzip a.zip && cd /root/run/ && ./_run1.sh &'

ssh root@157.245.200.108 'ls -1 run/tmp/user-profiles/ | wc -l'

now=$(date +%H%M%S) && ssh root@157.245.200.108 "cd /root/run/ && rm -rf done* && mkdir done_$now && find tmp/user-profiles/ -name '*.json' -exec mv -t done_$now/ {} + && zip -r done_$now.zip done_$now/"
scp root@157.245.200.108:'/root/run/done_*.zip' /Users/quang/Downloads/ok/user-profiles/



commands = []
max_num = 20
cursors = Cursor.where("page%#{max_num}=0").order(:page)

User.where("is_tracked=true").each do |u|
  if u.followers > max_num
    cursors[..(u.followers/max_num+1)].each_with_index do |cursor, i|
      commands.push "./GetUserFollowers.sh #{u.username} #{cursor.code}"
    end
  end
  if u.following > max_num
    cursors[..(u.following/max_num+1)].each_with_index do |cursor, i|
      commands.push "./GetUserFollowing.sh #{u.username} #{cursor.code}"
    end
  end
end

commands = []
usernames = User.where("(fullscans_needed IS NOT NULL OR is_tracked=true) and (is_trashed is null or is_trashed=false)").select(:id, :username).collect {|p| p.username}
usernames.uniq.sort.each do |username|
  commands.push "./GetUserProfile.sh #{username}"
end

slipt_commands_to_files(commands, 15)



def import_profiles json_path="tmp/run/tmp/", fullscans_needed=true
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    next if !(File.exist?(fn) && !File.zero?(fn))
    data = parse_json(File.read(fn))
    next if data.nil?
    if data["data"]
      if data["data"]["profile"]
        user = helper_get_user_by_node_data(data["data"]["profile"])
        user.fullscans_needed = nil if !user.fullscans_needed.nil? && fullscans_needed
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


10.times { import_profiles "/Users/quang/Downloads/ok/user-profiles", true }
import_profiles "/Users/quang/Downloads/ok/user-followers", false
import_profiles "/Users/quang/Downloads/ok/user-following", false




def import_zprofiles json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    next if !(File.exist?(fn) && !File.zero?(fn))
    data = parse_json(File.read(fn))
    next if data.nil?
    user = helper_get_user_by_node_data(data)
    user.save
    system "rm #{fn}"
  end
end


10.times { import_zprofiles "/Users/quang/Downloads/ok/users-json" }
