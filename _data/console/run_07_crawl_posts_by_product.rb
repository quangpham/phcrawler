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


# Buoc 8
# Import posts
# Update mot vai thuoc tinh cua posts
# Update them voters

def post_version obj
  version = ""
  if obj.id.nil?
    version = "new-by-product"
  else
    version = "product-05|#{obj.version}"
  end
  return version.gsub(" ","").split("|").uniq.join("|")
end

def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      product_id = data["data"]["product"]["id"].to_i

      data["data"]["product"]["posts"]["edges"].each do |p|
        post = helper_get_post_by_node_data(p["node"])
        post.product_id = product_id
        post.version = post_version(post)
        post.save
      end

      if data["data"]["product"]["posts"]["edges"].count > 0
        system "rm #{fn}"
      end

    rescue
      next
    end
  end
end

