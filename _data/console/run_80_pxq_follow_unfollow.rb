pxq85_id = 5849596
not_user_ids = [pxq85_id] + TrackedUserFollowing.where(user_id: pxq85_id).collect {|u| u.following_id}
user_ids  = []
user_ids += CustomUser.where("org_created_at > (now() - '60 days'::interval) and posts_count > 5").select(:id).collect {|u| u.id}
user_ids += User.where("(username like '%hoang%' or username like '%phan%' or username like '%bui%' or username like '%ngo%' or username like '%hoang%' or username like '%huynh%' or username like '%nguyen%' or username like '%dang%' or username like '%duong%' or username like '%tran%' or username like '%pham%') and following > 10 and last_active_at > '2023-01-01 00:00:21'").select(:id).collect {|u| u.id}
user_ids = (user_ids - not_user_ids).uniq

raw_sql = user_ids.sort.collect {|id| "INSERT INTO tracked_user_followings (user_id,following_id,action) VALUES(#{pxq85_id}, #{id}, 'follow');" }
ActiveRecord::Base.connection.execute(raw_sql.join(";"))

##


following_ids = []
TrackedUserFollowing.where("user_id=#{pxq85_id} and action='follow'").order(:following_id).limit(60).each do |u|
  system "cd _data/scripts/ && ./KevinPhamfollowAUser.sh #{u.following_id}"
  fn = "_data/scripts/tmp/pxq85-followed/#{u.following_id}.json"
  data = parse_json(File.read(fn))
  if following_id = helper_get_node_by_path(data, "data,response,node,id", "int")
    puts following_id
    following_ids.push(following_id)
  end
end

TrackedUserFollowing.where(user_id: pxq85_id, following_id: following_ids).update_all(action: "followed", followed_at: Time.now())




####
following_ids = []
TrackedUserFollowing.where("user_id=5849596 and note='_unfollowed'").order(:following_id).limit(50).each do |u|
  system "cd _data/scripts/ && ./KevinPhamUnfollowAUser.sh #{u.following_id}"
  fn = "_data/scripts/tmp/pxq85-unfollowed/#{u.following_id}.json"
  data = parse_json(File.read(fn))
  if following_id = helper_get_node_by_path(data, "data,response,node,id", "int")
    puts following_id
    following_ids.push(following_id)
  end
end

following_ids = []
json_path = "_data/scripts/tmp/pxq85-unfollowed"
Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
  next if !(File.exist?(fn) && !File.zero?(fn))
  data = parse_json(File.read(fn))
  next if data.nil?
  if following_id = helper_get_node_by_path(data, "data,response,node,id", "int")
    following_ids.push(following_id)
  end
end


TrackedUserFollowing.where(user_id: 5849596, following_id: following_ids).update_all(note: "unfollowed")
