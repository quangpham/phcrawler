# Buoc 7
# Tao file crawl them posts cho 1 product
# Muc tieu:
# - Lay het posts cua 1 product
# - Lay them data cua posts duoc crawl (contributors, topic_ids, etc)
# Note:
# - 10 posts/lan

# SQL Query:
sql = '
  update products p set sys_posts_count=t.posts_count
  from (
    select product_id,count(id) as posts_count from posts
    group by product_id
  ) t
  where p.id = t.product_id;
'


commands = []
Product.where("posts_count>sys_posts_count").each do |t|
  cursors[..(t.posts_count/10+2)].each_with_index do |cursor, i|
    commands.push "./GetPostsByProduct.sh #{1000+i} #{t.slug} #{cursor}"
  end
end

slipt_commands_to_files(commands, 10, cursors)


###
commands = []
Product.where("versions is null and is_trashed is null").each do |t|
  commands.push "./GetPostsByProduct.sh #{t.slug}"
end
slipt_commands_to_files(commands, 10)



# Buoc 8
# Import posts
# Update mot vai thuoc tinh cua posts
# Update them voters

def post_version obj
  version = ""
  if obj.id.nil?
    version = "new-by-product"
  else
    version = "product-06|#{obj.version}"
  end
  return version.gsub(" ","").split("|").uniq.join("|")
end


def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/**/*.json".gsub("//","/")].shuffle.each do |fn|
    if File.exist?(fn) && !File.zero?(fn)
      data = JSON.parse(File.read(fn))
      if data["data"]
        slug = fn.split("/").last.split(".").first

        if product_data = helper_get_node_by_path(data, "data,product")
          product_id = product_data["id"].to_i

          product = helper_get_product_by_node_data(product_data)
          product.versions = product.versions.nil? ? [0] : ([0] + product.versions).uniq
          product.save

          if slug!=product.slug
             if p = Product.find_by(slug: slug)
              p.delete
             end
          end

          if product_data["posts"]["edges"].count > 0
            system "rm #{fn}"
          end

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


