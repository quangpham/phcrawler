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


ssh root@159.89.192.33 "cd /root/run/ && mkdir -p done_07_a/a done_07_a/b tmp/reviewers-by-product/ && find tmp/posts-by-product/ -name '*.json' -exec mv -t done_07_a/a/ {} + && find tmp/reviewers-by-product/ -name '*.json' -exec mv -t done_07_a/b/ {} + && zip -r done_07_a.zip done_07_a/"
scp root@159.89.192.33:/root/run/done_07_a.zip /Users/quang/Downloads/ok/posts-by-product/

#
#
#
# Tao lenh crawl
commands = []
slugs = []
slugs += Product.where(fullscans_check: true).select(:id, :slug).collect {|p| p.slug}
slugs += Product.where("(fullscans ='{}') and (is_trashed=false or is_trashed is null)").select(:id, :slug).collect {|p| p.slug}
slugs += Product.where("(id in (select distinct product_id from posts where org_created_at > now() - interval '90 day') ) and (is_trashed=false or is_trashed is null)").select(:id, :slug).collect {|p| p.slug}
slugs += Product.where("(id in (select distinct product_id from posts where org_updated_at > now() - interval '30 day') ) and (is_trashed=false or is_trashed is null)").select(:id, :slug).collect {|p| p.slug}
slugs.uniq.sort.each do |slug|
  commands.push "./GetPostsByProductR.sh #{slug}"
end

slipt_commands_to_files(commands, 15)


# Buoc 8
# Import posts
# Update mot vai thuoc tinh cua posts
# Update them voters

def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].sort.each do |fn|
    if File.exist?(fn) && !File.zero?(fn)
      data = parse_json(File.read(fn))
      next if data.nil?

      if data["data"]
        slug = fn.split("/").last.split(".").first

        if product_data = helper_get_node_by_path(data, "data,product")
          product_id = product_data["id"].to_i
          product = helper_get_product_by_node_data(product_data)
          # product.fullscans = (product.fullscans + [Date.today.yday()] ).uniq.sort
          product.fullscans_needed = nil if product.fullscans_needed == true
          product.save

          if slug!=product.slug
             if p = Product.find_by(slug: slug)
              p.delete
             end
          end

          system "rm #{fn}" if product_data["createdAt"]
        else
          if product = Product.find_by(slug: slug)
            product.is_trashed = true
            product.save
            system "rm #{fn}"
          end
        end
      end

    end
  end
end

import_posts "/Users/quang/Downloads/ok/posts-by-product"
import_posts "/Users/quang/Projects/upbase/phcrawler/tmp/run/tmp/posts-by-product"
import_posts "/Users/quang/Projects/upbase/phcrawler/_data/scripts/tmp/posts-by-product"


