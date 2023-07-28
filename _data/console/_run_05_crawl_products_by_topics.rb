# Buoc 5
# Tao file Crawl products theo topic
# Muc dich
# - crawl them reviewers (max 20)
# - crawl them posts (not-detail) (max 100) tu products
# Notes:
# - Chi can crawl root topic
# - Moi lan crawl duoc 20 products/lan
# Extra:
# - product co posts_count > 100 => crawl lai trang product detail
# - product co reviews_count > 20 => tim cach crawl them

commands = []
Topic.where("parent_id is null and products_count is not null").each do |t|
  cursors[..(t.products_count/20+2)].each_with_index do |cursor, i|
    commands.push "./GetProductsByTopic.sh #{1000+i} #{t.slug} most_recent #{cursor}"
  end
end

slipt_commands_to_files(commands, 15, cursors)


# Buoc 6
# Sync data + server
# Import products
def products_by_topic_version obj
    return obj.id.nil? ? nil : "tp02"
end

def import_products json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      data["data"]["topic"]["products"]["edges"].each do |pen|
        product = helper_get_product_by_node_data(pen["node"])
        product.version = products_by_topic_version(product)
        # if product.note
        #   product.note = (product.note.split("|") - [""]).uniq.sort.join("|")
        # end
        product.save
      end

      if data["data"]["topic"]["products"]["edges"].count > 0
        system "rm #{fn}"
      end

    rescue
      next
    end
  end
end

# import_products "/Users/quang/Downloads/done_4"
