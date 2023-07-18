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

def import_reviewers json_path="tmp/run/tmp/"
    Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
        begin
            data = JSON.parse(File.read(fn))
            n = data["data"]["product"]
            product_id = data["data"]["product"]["id"].to_i
            product = Product.find_or_initialize_by(id: product_id)
            product.slug = n["slug"]
            product.name = n["name"]
            product.tagline = n["tagline"]
            product.logo_uuid = n["logoUuid"]
            product.followers_count = n["followersCount"]
            product.reviews_rating = n["reviewsRating"]
            product.s_created_at = n["createdAt"]

            raw_sql = ""
            product.reviewers_ids = ([product.reviewers_ids] + []).flatten.compact

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
            product.save
            ActiveRecord::Base.connection.execute(raw_sql)

            if n["reviews"]["edges"].count > 0
                system "rm #{fn}"
            end
        rescue
        end
    end
end
