

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
