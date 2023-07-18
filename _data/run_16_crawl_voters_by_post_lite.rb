
def import_voters_lite json_path="tmp/run/tmp/"
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



      data["contributors"].each do |n|
        u = n["user"]
        user_id = n["user"]["id"].to_i
        user = User.find_or_initialize_by(id: user_id)
        user.username = u["username"] || user.username
        user.twitter = u["twitterUsername"] || user.twitter
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
        post.save
        # system "rm #{fn2}"
      end
    rescue
    end
  end
end

import_voters_lite "/Users/quang/Projects/upbase/phcrawler/_data/tmp"

# import_voters "/Users/quang/Downloads/done_4/"
