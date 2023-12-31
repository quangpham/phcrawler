# Tao file crawl voters

# GetVotersByPost, GetVotersByPostLite
#
# Lite de crawl duoc full contributors, nhung thieu fields
# Users chi id username twitterUsername createdAt
# Tinh toan xem luc nao dung Lite, luc nao ko dung
#
# Post.where("is_checked is not null").each do |p|


# update posts set sys_votes_count=array_length(uniq(upvoter_ids||commenter_ids||hunter_ids||maker_ids),1);

scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@157.245.200.108:/root/a.zip
ssh root@157.245.200.108 'cd /root/ && rm -rf run* && unzip a.zip && cd /root/run/ && ./run.sh &'

ssh root@157.245.200.108 'ls -1 run/tmp/voters-by-post/ | wc -l'

now=$(date +%H%M%S) && ssh root@157.245.200.108 "cd /root/run/ && mkdir done_$now && find tmp/voters-by-post/ -name '*.json' -exec mv -t done_$now/ {} + && zip -r done_$now.zip done_$now/"
scp root@157.245.200.108:/root/run/done_$now.zip /Users/quang/Downloads/ok/voters-by-post/


commands = []
slugs = []
slugs += Post.where("fullscans_needed=true and (is_trashed is null or is_trashed=false)").select(:id, :slug).collect {|p| p.slug}
slugs += Post.where("org_created_at > now() - interval '60 day' and (is_trashed is null or is_trashed=false)").select(:id, :slug).collect {|p| p.slug}
slugs += Post.where("org_updated_at > now() - interval '45 day' and (is_trashed is null or is_trashed=false)").select(:id, :slug).collect {|p| p.slug}
# slugs += Post.where("(is_trashed is null or is_trashed=false)").select(:id, :slug).collect {|p| p.slug}
slugs.uniq.sort.each do |slug|
  commands.push "./GetVotersByPost.sh #{slug} 100000"
end

slipt_commands_to_files(commands, 15)

# Buoc 21
# Sync len server de chay
# Sync results ve local

# Buoc 22
# Import Voters
# Lam them phan topic_ids, votesCount commentsCount updatedAt
#

def import_voters json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    next if !(File.exist?(fn) && !File.zero?(fn))
    data = parse_json(File.read(fn))
    next if data.nil?
    if data["data"]
      # slug = fn.split("/").last.split(".json").first
      if post_data = helper_get_node_by_path(data, "data,post")
        post = helper_get_post_by_node_data(post_data)
        post.fullscans_needed = nil if post.fullscans_needed == true
        post.save
        if post_data["contributors"].count > 0
          system "rm #{fn}"
        end
        # Post.where("slug=? and id!=?", slug, post.id).delete_all
      # else
      #   if _post = Post.find_by(slug: slug)
      #     _post.is_trashed = true
      #     _post.save
      #     system "rm #{fn}"
      #   end
      end

    end
  end
end

10.times {import_voters "/Users/quang/Downloads/ok/voters-by-post"}

import_voters "tmp/run/tmp/voters-by-post"
