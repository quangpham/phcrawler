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


scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@157.245.200.108:/root/a.zip
ssh root@157.245.200.108 'cd /root/ && rm -rf run* && unzip a.zip && cd /root/run/ && ./run.sh &'

ssh root@157.245.200.108 'ls -1 run/tmp/posts-by-product/ | wc -l'
ssh root@157.245.200.108 'ls -1 run/tmp/reviewers-by-product/ | wc -l'

mkdir -p /Users/quang/Downloads/ok/posts-by-product/
now=$(date +%H%M%S) && ssh root@157.245.200.108 "cd /root/run/ && mkdir -p done_$now/a done_$now/b tmp/reviewers-by-product/ && find tmp/posts-by-product/ -name '*.json' -exec mv -t done_$now/a/ {} + && find tmp/reviewers-by-product/ -name '*.json' -exec mv -t done_$now/b/ {} + && zip -r done_$now.zip done_$now/"
scp root@157.245.200.108:/root/run/done_$now.zip /Users/quang/Downloads/ok/posts-by-product/



# Tao lenh crawl
commands = []
slugs = []
slugs += Product.where(fullscans_needed: true).select(:id, :slug).collect {|p| p.slug}
slugs += Product.where("(id in (select distinct product_id from posts where org_created_at > now() - interval '60 day') ) and (is_trashed=false or is_trashed is null)").order(:id).select(:id, :slug).collect {|p| p.slug}
slugs += Product.where("(id in (select distinct product_id from posts where org_updated_at > now() - interval '45 day') ) and (is_trashed=false or is_trashed is null)").order(:id).select(:id, :slug).collect {|p| p.slug}
# slugs += Product.where("(is_trashed=false or is_trashed is null)").select(:id, :slug).collect {|p| p.slug}
slugs.uniq.each do |slug|
  commands.push "./GetPostsByProductR.sh #{slug}"
end

slipt_commands_to_files(commands, 15)


# Buoc 8
# Import posts
# Update mot vai thuoc tinh cua posts
# Update them voters

def import_posts_by_product json_path="tmp/run/tmp/"
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

10.times { import_posts_by_product "/Users/quang/Downloads/ok/posts-by-product" }
import_posts_by_product "/Users/quang/Projects/upbase/phcrawler/tmp/run/tmp/posts-by-product"
import_posts_by_product "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp/posts-by-product"
