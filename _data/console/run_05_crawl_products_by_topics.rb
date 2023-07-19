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
        n = pen["node"]
        product_id = n["id"].to_i
        product = Product.find_or_initialize_by(id: product_id)
        product.slug = n["slug"]
        product.name = n["name"]
        product.tagline = n["tagline"]
        product.logo_uuid = n["logoUuid"]

        product.followers_count = n["followersCount"]
        product.reviews_rating = n["reviewsRating"]
        product.s_created_at = n["createdAt"]

        if n["topics"]
          if n["topics"]["edges"].count > 0
            product.topic_ids = [] if product.topic_ids.nil?
            n["topics"]["edges"].each do |t|
              product.topic_ids.push(t["node"]["id"].to_i)
            end
            product.topic_ids = product.topic_ids.uniq.compact.sort
            product.topic_ids = nil if product.topic_ids.empty?
          end
        end

        if n["posts"]
          edges_count = n["posts"]["edges"].count
          product.posts_count = n["posts"]["totalCount"]
          # if product.posts_count > edges_count
          #   product.note = "#{product.note}|p #{edges_count}-#{product.posts_count}"
          # end
          if edges_count > 0
            product.post_ids = [] if product.post_ids.nil?
            n["posts"]["edges"].each do |t|
              ppost = Post.find_or_initialize_by(id: t["node"]["id"].to_i)
              ppost.slug = t["node"]["slug"]
              ppost.s_created_at = t["node"]["createdAt"]
              ppost.product_id = product_id
              ppost.save
              product.post_ids.push(ppost.id)
            end
            product.post_ids = product.post_ids.uniq.compact.sort
            product.post_ids = nil if product.post_ids.empty?
          end
        end

        if n["reviews"]
          edges_count = n["reviews"]["edges"].count
          product.reviews_count = n["reviews"]["totalCount"]
          # if product.reviews_count > edges_count
          #   product.note = "#{product.note}|r #{edges_count}-#{product.reviews_count}"
          # end
          if edges_count > 0
            raw_sql = ""
            product.reviewers_ids = [] if product.reviewers_ids.nil?
            n["reviews"]["edges"].each do |r|
              un = r["node"]["user"]
              user = User.find_or_initialize_by(id: un["id"].to_i)
              user.name = un["name"]
              user.username = un["username"] || user.username
              user.twitter = un["twitterUsername"] || user.twitter
              user.website = un["websiteUrl"] || user.website
              user.followers = un["followersCount"]
              user.following = un["followingsCount"]
              user.badges = un["badgesCount"]
              user.score = un["karmaBadge"]["score"]
              user.is_trashed = un["isTrashed"]
              user.s_created_at = un["createdAt"]
              user.save
              product.reviewers_ids.push(user.id)
              raw_sql += "INSERT INTO product_reviewer (product_id, user_id, created_at) VALUES(#{product_id},#{user.id},'#{r["node"]["createdAt"]}') ON CONFLICT (product_id, user_id) DO NOTHING;"
            end
            product.reviewers_ids = product.reviewers_ids.uniq.compact
            product.reviewers_ids = nil if product.reviewers_ids.empty?
            ActiveRecord::Base.connection.execute(raw_sql)
          end
        end

        product.version = products_by_topic_version(product)
        if product.note
          product.note = (product.note.split("|") - [""]).uniq.sort.join("|")
        end
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
