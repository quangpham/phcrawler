# Buoc 7
# Tao file crawl them posts cho 1 product
# Muc tieu:
# - Lay het posts cua 1 product
# - Lay them data cua posts duoc crawl (contributors, topic_ids, etc)
# Note:
# - 20 posts/lan -> R
# - Crawl R luon GetReviewersByProduct
#
# Extra
# Neu chay full, scan all thi tao lai command
#


scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@128.199.106.41:/root/a.zip
ssh root@128.199.106.41 'cd /root/ && rm -rf run* && unzip a.zip'

ssh root@128.199.106.41 'ls -1 run/tmp/posts-by-product/ | wc -l'
ssh root@128.199.106.41 'ls -1 run/tmp/reviewers-by-product/ | wc -l'

mkdir -p /Users/quang/Downloads/ok/posts-by-product/
ssh root@128.199.106.41 "cd /root/run/ && mkdir -p done_01_a/a done_01_a/b tmp/reviewers-by-product/ && find tmp/posts-by-product/ -name '*.json' -exec mv -t done_01_a/a/ {} + && find tmp/reviewers-by-product/ -name '*.json' -exec mv -t done_01_a/b/ {} + && zip -r done_01_a.zip done_01_a/"
scp root@128.199.106.41:/root/run/done_01_a.zip /Users/quang/Downloads/ok/posts-by-product/



# Tao lenh crawl
commands = []
slugs = []
slugs += Product.where(fullscans_needed: true).select(:id, :slug).collect {|p| p.slug}
slugs += Product.where("(id in (select distinct product_id from posts where org_created_at > now() - interval '30 day') ) and (is_trashed=false or is_trashed is null)").select(:id, :slug).collect {|p| p.slug}
slugs += Product.where("(id in (select distinct product_id from posts where org_updated_at > now() - interval '15 day') ) and (is_trashed=false or is_trashed is null)").select(:id, :slug).collect {|p| p.slug}
slugs.uniq.sort.each do |slug|
  commands.push "./GetPostsByProductR.sh #{slug}"
end

slipt_commands_to_files(commands, 15)


# Buoc 8
# Import posts
# Update mot vai thuoc tinh cua posts
# Update them voters

def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    next if !(File.exist?(fn) && !File.zero?(fn))
    data = parse_json(File.read(fn))
    next if data.nil?
    if product_data = helper_get_node_by_path(data, "data,product")
      product = helper_get_product_by_node_data(product_data)
      product.fullscans_needed = nil if product.fullscans_needed == true
      product.save
      system "rm #{fn}" if product_data["createdAt"]
    end
  end
end

import_posts "/Users/quang/Downloads/ok/posts-by-product"
import_posts "/Users/quang/Projects/upbase/phcrawler/tmp/run/tmp/posts-by-product"
import_posts "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp/posts-by-product"


