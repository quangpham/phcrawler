# Sua lai id thanh slug
#
#
#
# Buoc 20
# Tao file crawl contribuitors
# Crawl Voters
init_tmp()
p_ids = Post.where("((old_votes is null) OR (old_votes is not null and votes!=old_votes)) AND votes < 13000").collect {|p| p.slug}
p_ids = Post.where("votes_count < 100000 OR votes_count IS NULL").collect {|p| p.slug}
run_content_str = ""
number_split_files = 15
p_ids.each_slice(p_ids.count/number_split_files = 15).to_a.each_with_index do |arr, i|
  str = ""
  arr.each {|id| str= str + "./ContributorsByPost.sh #{id} 100000\n"}
  File.open("tmp/run/#{i}.sh", 'w') { |file| file.write(str) }
  system "chmod u+x tmp/run/#{i}.sh"
  run_content_str += "\n./#{i}.sh & \n"
end
File.open("tmp/run/run.sh", 'w') { |file| file.write(run_content_str) }

# Buoc 21
# Sync len server de chay
# Sync results ve local

# Buoc 22
# Import Voters
# Lam them phan topic_ids, votesCount commentsCount updatedAt
def import_voters json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].shuffle.each do |fn|

    begin
      next if !File.exist?(fn)
      next if File.zero?(fn)
      fn2 = fn.gsub(".json",".ongoing")
      system "mv #{fn} #{fn2}"

      _data = JSON.parse(File.read(fn2))
      data = _data["data"]["post"]
      post = Post.find_by(id: data["id"].to_i)
      post.hunter_ids = [] if post.hunter_ids.nil?
      post.maker_ids = [] if post.maker_ids.nil?
      post.commenter_ids = [] if post.commenter_ids.nil?
      post.upvoter_ids = [] if post.upvoter_ids.nil?
      post.votes_count = data["votesCount"] || post.votes_count
      post.comments_count = data["commentsCount"] || post.comments_count
      post.s_updated_at = data["updatedAt"] || post.s_updated_at

      if data["topics"]
        post.topic_ids = [] if post.topic_ids.nil?
        data["topics"]["edges"].each do |n|
          post.topic_ids.push(n["node"]["id"].to_i)
        end
        post.topic_ids = post.topic_ids.uniq.compact.sort
        post.topic_ids = nil if post.topic_ids.empty?
      end

      data["contributors"].each do |n|
        u = n["user"]
        user_id = n["user"]["id"].to_i
        user = User.find_or_initialize_by(id: user_id)
        user.name = u["name"] || user.name
        user.username = u["username"] || user.username
        user.headline = u["headline"] || user.headline
        user.website = u["websiteUrl"] || user.website
        user.twitter = u["twitterUsername"] || user.twitter
        user.is_maker = u["isMaker"]
        user.is_trashed = u["isTrashed"]
        user.badges = [u["badgesCount"].to_i, u["badgesUniqueCount"].to_i].max
        user.followers = u["followersCount"]
        user.following = u["followingsCount"]
        user.score = u["karmaBadge"]["score"]
        user.s_created_at = u["createdAt"]
        post.hunter_ids.push(user_id) if !n["role"].index("hunter").nil?
        post.maker_ids.push(user_id) if !n["role"].index("maker").nil?
        post.commenter_ids.push(user_id) if !n["role"].index("commenter").nil?
        post.upvoter_ids.push(user_id) if !n["role"].index("upvoter").nil?
        user.save
      end

      if data["contributors"].count > 0
        post.hunter_ids = post.hunter_ids.uniq.compact.sort
        post.hunter_ids = nil if post.hunter_ids.empty?
        post.maker_ids = post.maker_ids.uniq.compact.sort
        post.maker_ids = nil if post.maker_ids.empty?
        post.commenter_ids = post.commenter_ids.uniq.compact.sort
        post.commenter_ids = nil if post.commenter_ids.empty?
        post.upvoter_ids = post.upvoter_ids.uniq.compact.sort
        post.upvoter_ids = nil if post.upvoter_ids.empty?
        post.version = 2
        post.save
        system "rm #{fn2}"
      end
    rescue
    end
  end
end

# import_voters "/Users/quang/Downloads/done_4/"
