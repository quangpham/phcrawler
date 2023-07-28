# Tao file crawl voters

# GetVotersByPost, GetVotersByPostLite
#
# Lite de crawl duoc full contributors, nhung thieu fields
# Users chi id username twitterUsername createdAt
# Tinh toan xem luc nao dung Lite, luc nao ko dung
#
# Post.where("is_checked is not null").each do |p|


# update posts set sys_votes_count=array_length(uniq(upvoter_ids||commenter_ids||hunter_ids||maker_ids),1);


commands = []
Post.where("(is_checked=false or is_checked is null) and version is null").each do |p|
  commands.push "./GetVotersByPost.sh #{p.slug} 100000"
end
slipt_commands_to_files(commands, 15)

# Buoc 21
# Sync len server de chay
# Sync results ve local

# Buoc 22
# Import Voters
# Lam them phan topic_ids, votesCount commentsCount updatedAt
#

def post_version obj
  version = ""
  if obj.id.nil?
    version = "new-by-voters"
  else
    version = "voters-04|#{obj.version}"
  end
  return version.gsub(" ","").split("|").uniq.join("|")
end

def import_voters json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    if File.exist?(fn) && !File.zero?(fn)
      fn2 = fn.gsub(".json",".ongoing")
      system "mv #{fn} #{fn2}"

      data = JSON.parse(File.read(fn2))

      if data["data"]
        if post_data = helper_get_node_by_path(data, "data,post")
          post = helper_get_post_by_node_data(post_data)
          post.versions = post.versions.nil? ? [0] : ([0] + post.versions).uniq
          # post.version = post_version(post)
          # post.is_checked = true
          post.save

          if post_data["contributors"].count > 0
            system "rm #{fn2}"
          end
        else
          slug = fn2.split("/").last.split(".ongoing").first
          if _post = Post.find_by(slug: slug)
            _post.is_trashed = true
            _post.save
            system "rm #{fn2}"
          end
        end

      end

    end
  end
end

import_voters "/Users/quang/Downloads/ok/voters-by-post"
# import_voters "/Users/quang/Downloads/done_4/"
