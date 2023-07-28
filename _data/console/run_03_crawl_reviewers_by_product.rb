# Buoc 10
# Tao file crawl them reviewers cua product
# Muc tieu:
# - Lay het reviews, reviewers cua 1 product
# Note:
# - 20 reviews/lan


# SQL Query truoc
sql = '
    update products p set sys_reviews_count=t.reviews_count
    from (
        select product_id,count(user_id) as reviews_count from product_reviewer
        group by product_id
    ) t
    where p.id = t.product_id;
'

commands = []
Product.where("reviews_count>sys_reviews_count and reviews_count > 19").each do |t|
  cursors[..(t.reviews_count/20+1)].each_with_index do |cursor, i|
    commands.push "./GetReviewersByProduct.sh #{1000+i} #{t.slug} #{cursor}"
  end
end

slipt_commands_to_files(commands, 15, cursors)


# Buoc 11
# Import reviewers
#

def products_by_topic_version obj
    return obj.id.nil? ? nil : "by-reviews-01|#{obj.version}"
end

def import_reviewers json_path="tmp/run/tmp/"
    Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
        begin
            data = JSON.parse(File.read(fn))
            n = data["data"]["product"]

            product = helper_get_product_by_node_data(n)
            product.version = products_by_topic_version(product)

            if n["reviews"]["edges"].count > 0
                system "rm #{fn}"
            end
        rescue
        end
    end
end
