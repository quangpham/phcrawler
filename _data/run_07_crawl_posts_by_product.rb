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
  return obj.id.nil? ? "new" : "p_p_1"
end

def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      product_id = data["data"]["product"]["id"].to_i

      data["data"]["product"]["posts"]["edges"].each do |p|
        n = p["node"]
        post_id = n["id"].to_i
        post = Post.find_or_initialize_by(id: post_id)
        post.name = n["name"]
        post.slug = n["slug"]
        post.tagline = n["tagline"]
        post.pricing_type = n["pricingType"]
        post.comments_count = n["commentsCount"]
        post.votes_count = n["votesCount"]
        post.s_created_at = n["createdAt"]
        post.s_featured_at = n["featuredAt"]
        post.s_updated_at = n["updatedAt"]
        post.product_id = product_id

        if n["topics"]
          post.topic_ids = ([post.topic_ids] + []).flatten.compact
          n["topics"]["edges"].each do |t|
            post.topic_ids.push(t["node"]["id"].to_i)
          end
          post.topic_ids = post.topic_ids.uniq.compact.sort
          post.topic_ids = nil if post.topic_ids.empty?
        end

        if n["contributors"]
          if n["contributors"].count > 0

            post.hunter_ids = [] if post.hunter_ids.nil?
            post.maker_ids = [] if post.maker_ids.nil?
            post.commenter_ids = [] if post.commenter_ids.nil?
            post.upvoter_ids = [] if post.upvoter_ids.nil?

            n["contributors"].each do |cn|
              u = cn["user"]
              user_id = u["id"].to_i
              user = User.find_or_initialize_by(id: user_id)
              user.name = u["name"] || user.name
              user.username = u["username"] || user.username
              user.headline = u["headline"] || user.headline
              user.website = u["websiteUrl"] || user.website
              user.twitter = u["twitterUsername"] || user.twitter
              user.is_maker = u["isMaker"]
              user.is_trashed = u["isTrashed"]
              user.badges = [u["badgesCount"].to_i, u["badgesUniqueCount"].to_i].max
              user.followers = u["followersCount"]
              user.following = u["followingsCount"]
              user.score = u["karmaBadge"]["score"]
              user.s_created_at = u["createdAt"]
              user.save

              post.hunter_ids.push(user_id) if !cn["role"].index("hunter").nil?
              post.maker_ids.push(user_id) if !cn["role"].index("maker").nil?
              post.commenter_ids.push(user_id) if !cn["role"].index("commenter").nil?
              post.upvoter_ids.push(user_id) if !cn["role"].index("upvoter").nil?
            end

            post.hunter_ids = post.hunter_ids.uniq.compact.sort
            post.hunter_ids = nil if post.hunter_ids.empty?
            post.maker_ids = post.maker_ids.uniq.compact.sort
            post.maker_ids = nil if post.maker_ids.empty?
            post.commenter_ids = post.commenter_ids.uniq.compact.sort
            post.commenter_ids = nil if post.commenter_ids.empty?
            post.upvoter_ids = post.upvoter_ids.uniq.compact.sort
            post.upvoter_ids = nil if post.upvoter_ids.empty?
          end
        end
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

