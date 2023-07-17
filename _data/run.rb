# TODO
# Crawl subcribers qua TopicPage
# Crawl recentStacks qua TopicPage

# Buoc 1 
# Init tmp
def init_tmp
  system "mkdir -p tmp/run/ && rm -R tmp/run/ && mkdir -p tmp/run/"
  system "cp _data/GetTopicDetail.sh tmp/run/GetTopicDetail.sh"
  system "cp _data/GetProductsByTopicFull.sh tmp/run/GetProductsByTopicFull.sh"

  system "cp _data/ContributorsByPost.sh tmp/run/ContributorsByPost.sh"
  system "touch tmp/run/run.sh && chmod u+x tmp/run/run.sh"
end


# Buoc 2
# CRAWL & IMPORT TOPICS

system "_data/Topic.sh"

fn = "tmp/topics.json"
data = JSON.parse(File.read(fn))
    
data["data"]["topics"]["edges"].each do |n|
  t = n["node"]
  topic = Topic.find_or_initialize_by(id: t["id"].to_i)
  topic.name = t["name"]
  topic.slug = t["slug"]
  topic.followers_count = t["followersCount"]
  topic.posts_count = t["postsCount"]
  if t["parent"]
    parent = Topic.find_or_create_by(id: t["parent"]["id"].to_i)
    topic.parent_id = parent.id
  end
  if t["posts"]
    topic.real_posts_count = t["posts"]["totalCount"]
  end
  if t["products"]
    topic.products_count =t["products"]["totalCount"]
  end
  if t["recentStacks"]
    topic.recent_stacks_count =t["recentStacks"]["totalCount"]
  end
  topic.version = 1
  topic.save
end


# Buoc 3
# Tao file crawl posts theo topic
# Chi can tao cho topic parent la duoc
# Crawl luon upvoters (max 200) | Thang nao >200, thi crawl post detail de lay upvoters
# Crawl upn topic_ids cua post
# Khong product_id, created_at, featured_at, pricing_type, rating, tagline, topics_count
# Nho them version cho posts, va thay version cho users
# Split files de chay tren server

# Buoc 4
# Sync results posts-by-topic
# Tao/Update posts moi
# Tao/Upbase users moi



# Buoc 5
# Tao file crawl products theo topic voi page cursor
# SPlit file ra thanh 10 files

init_tmp
cursors = File.read("_data/cursors.txt").split(",")
commands = []
Topic.where("products_count > 0").each do |t|
  cursors[..(t.products_count/10+1)].each_with_index do |cursor, i|
    commands.push "./GetProductsByTopicFull.sh #{1000+i} #{t.slug} most_recent #{cursor}"
  end
end

number_split_files = 15
content_arr = []
number_split_files.times {content_arr.push([])}

File.open("tmp/run/run.sh", 'w') { |file| file.write( number_split_files.times.collect {|i| "./#{i}.sh &" }.join("\n") ) }

commands.each_with_index do |c,i|
  content_arr[i%number_split_files].push(c)
end

content_arr.each_with_index do |arr,i|
  File.open("tmp/run/#{i}.sh", 'w') { |file| file.write(arr.join(" \n")) }
  system "chmod u+x tmp/run/#{i}.sh"
end

# Buoc 6
# Sync len server de xu ly
# Sync nguoc file results ve local

# Buoc 7
# Import Products
# 

# IMPORT PRODUCT 
def import_products json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
    begin
      next if !File.exist?(fn)
      next if File.zero?(fn)
      data = JSON.parse(File.read(fn))
      data["data"]["topic"]["products"]["edges"].each do |pen|
        n = pen["node"]
        product_id = n["id"].to_i
        product = Product.find_or_initialize_by(id: product_id)
        product.slug = n["slug"]
        product.name = n["name"]
        product.tagline = n["tagline"]
        product.followers_count = n["followersCount"]
        product.reviews_count = n["reviewsCount"]
        product.reviews_rating = n["reviewsRating"]
        product.logo_uuid = n["logoUuid"]
        product.created_at = n["createdAt"]
        
        if n["topics"]
          product.topic_ids = ([product.topic_ids] + []).flatten.compact
          n["topics"]["edges"].each do |t|
            tn = t["node"]
            topic = Topic.find_or_initialize_by(id: tn["id"].to_i, slug: tn["slug"])
            if tn["parent"]
              topic.parent_id = tn["parent"]["id"].to_i
            end
            topic.save
            product.topic_ids.push(topic.id)
          end
          product.topic_ids = product.topic_ids.uniq.compact
          product.topic_ids = nil if product.topic_ids.empty?
          product.topics_count = n["topics"]["totalCount"].to_i
        end

        if n["posts"]
          product.post_ids = ([product.post_ids] + []).flatten.compact
          n["posts"]["edges"].each do |p|
            pn = p["node"]
            post = Post.find_or_initialize_by(id: pn["id"].to_i)
            post.product_id = product_id
            post.name = pn["name"]
            post.slug = pn["slug"]
            post.tagline = pn["tagline"]
            post.comments_count = pn["commentsCount"]
            post.s_created_at = pn["createdAt"]
            post.s_updated_at = pn["updatedAt"]
            post.s_featured_at = pn["featuredAt"]
            post.pricing_type = pn["pricingType"]
            post.votes_count = pn["votesCount"]
            if pn["topics"]
              post.topic_ids = ([post.topic_ids] + []).flatten.compact
              post.topics_count = pn["topics"]["totalCount"]
              pn["topics"]["edges"].each do |tt|
                post.topic_ids.push(tt["node"]["id"].to_i)
              end
              post.topic_ids = post.topic_ids.uniq.compact
              post.topic_ids = nil if post.topic_ids.empty?
            end
            post.save
            product.post_ids.push(post.id)
          end
          product.post_ids = product.post_ids.uniq.compact
          product.post_ids = nil if product.post_ids.empty?
          product.posts_count = n["posts"]["totalCount"].to_i
        end
        
        if n["reviews"]
          product.reviewers_ids = ([product.reviewers_ids] + []).flatten.compact
          n["reviews"]["edges"].each do |r|
            un = r["node"]["user"]
            user = User.find_or_initialize_by(id: un["id"].to_i)
            user.name = un["name"]
            user.username = user.username || un["username"]
            user.twitter = user.twitter || un["twitterUsername"]
            user.save
            product.reviewers_ids.push(user.id)
          end
          product.reviewers_ids = product.reviewers_ids.uniq.compact
          product.reviewers_ids = nil if product.reviewers_ids.empty?
        end
        
        product.save
      end

      if data["data"]["topic"]["products"]["edges"].count > 0
        system "rm #{fn}"
      else
        system "mv #{fn} #{fn.gsub(".json",".done")}"
      end

    end
  end
end

# import_products "/Users/quang/Downloads/done_4/"

# Buoc 8
# Manual check lai reviews(50), topics(100), posts(100)
# Crawl them nhung thanh phan con thieu


# Crawl topic's subscribers




# Buoc 20
# Tao file crawl contribuitors
# Crawl Voters
init_tmp()
p_ids = Post.where("((old_votes is null) OR (old_votes is not null and votes!=old_votes)) AND votes < 13000").collect {|p| p.slug}
p_ids = Post.where("votes_count < 100000 OR votes_count IS NULL").collect {|p| p.slug}
run_content_str = ""
number_split_files = 15
p_ids.each_slice(p_ids.count/number_split_files = 15
).to_a.each_with_index do |arr, i|
  str = ""
  arr.each {|id| str= str + "./ContributorsByPost.sh #{id} 100000\n"}
  File.open("tmp/run/#{i}.sh", 'w') { |file| file.write(str) }
  system "chmod u+x tmp/run/#{i}.sh"
  run_content_str += "\n./#{i}.sh & \n"
end
File.open("tmp/run/run.sh", 'w') { |file| file.write(run_content_str) }

# Buoc 21
# Sync len server de chay
# Sync results ve local

# Buoc 22
# Import Voters
# Lam them phan topic_ids, votesCount commentsCount updatedAt
def import_voters json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].shuffle.each do |fn|

    begin
      next if !File.exist?(fn)
      next if File.zero?(fn)
      fn2 = fn.gsub(".json",".ongoing")
      system "mv #{fn} #{fn2}"

      _data = JSON.parse(File.read(fn2))
      data = _data["data"]["post"]
      post = Post.find_by(id: data["id"].to_i)
      post.hunter_ids = [] if post.hunter_ids.nil?
      post.maker_ids = [] if post.maker_ids.nil?
      post.commenter_ids = [] if post.commenter_ids.nil?
      post.upvoter_ids = [] if post.upvoter_ids.nil?
      post.votes_count = data["votesCount"] || post.votes_count
      post.comments_count = data["commentsCount"] || post.comments_count
      post.s_updated_at = data["updatedAt"] || post.s_updated_at
      
      if data["topics"]
        post.topic_ids = [] if post.topic_ids.nil?
        data["topics"]["edges"].each do |n|
          post.topic_ids.push(n["node"]["id"].to_i)
        end
        post.topic_ids = post.topic_ids.uniq.compact.sort
        post.topic_ids = nil if post.topic_ids.empty?
      end

      data["contributors"].each do |n|
        u = n["user"]
        user_id = n["user"]["id"].to_i
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
        post.hunter_ids.push(user_id) if !n["role"].index("hunter").nil?
        post.maker_ids.push(user_id) if !n["role"].index("maker").nil?
        post.commenter_ids.push(user_id) if !n["role"].index("commenter").nil?
        post.upvoter_ids.push(user_id) if !n["role"].index("upvoter").nil?
        user.save
      end
    
      if data["contributors"].count > 0
        post.hunter_ids = post.hunter_ids.uniq.compact.sort
        post.hunter_ids = nil if post.hunter_ids.empty?
        post.maker_ids = post.maker_ids.uniq.compact.sort
        post.maker_ids = nil if post.maker_ids.empty?
        post.commenter_ids = post.commenter_ids.uniq.compact.sort
        post.commenter_ids = nil if post.commenter_ids.empty?
        post.upvoter_ids = post.upvoter_ids.uniq.compact.sort
        post.upvoter_ids = nil if post.upvoter_ids.empty?
        post.version = 2
        post.save
        system "rm #{fn2}"
      end
    rescue
    end
  end
end

# import_voters "/Users/quang/Downloads/done_3/"



####





# CRAWL POSTS


def crawl_posts(_topic)
  topic = _topic || "task-management" # "productivity"
  tmp_file = "tmp/_r.json"
  order = "most_recent" # "most-upvoted" "best_rated", "most_followed", "most_recent"
  
  system "_data/PostByTopic.sh 1001 #{topic} #{order}"
  
  for i in 2..10000
    if File.exist?(tmp_file)
      raw_data = File.read(tmp_file)
      data = JSON.parse(raw_data)
      next_cursor = data["data"]["topic"]["posts"]["pageInfo"]["endCursor"]
      if !next_cursor.blank?
        system "_data/PostByTopic.sh #{1000+i} #{topic} #{order} #{next_cursor}"
      else
        break
      end
    else 
      break
    end
  end
end

###

init_tmp
str = ""
Topic.where("real_posts is null").order(:slug).each {|t| str += "./PostByTopic.sh 1001 #{t.slug} by-date \n"}
File.open("tmp/run/run.sh", 'w') { |file| file.write(str) }


# File.open("_data/cursors.txt", 'w') { |file| file.write(cursors.join(",")) }
# cursors = Dir["tmp/_r.*.json"].sort.collect {|fn| fn.split("by-date.").last.split(".").first}

init_tmp
cursors = File.read("_data/cursors.txt").split(",")
commands = []
Topic.where("real_posts > 19").each do |t|
  cursors[..(t.real_posts/20+1)].each_with_index do |cursor, i|
    commands.push "./PostByTopic.sh #{1000+i} #{t.slug} by-date #{cursor}"
  end
end


number_split_files = 10
content_arr = []
number_split_files.times {content_arr.push([])}

File.open("tmp/run/run.sh", 'w') { |file| file.write( number_split_files.times.collect {|i| "./#{i}.sh &" }.join("\n") ) }

commands.each_with_index do |c,i|
  content_arr[i%number_split_files].push(c)
end

content_arr.each_with_index do |arr,i|
  File.open("tmp/run/#{i}.sh", 'w') { |file| file.write(arr.join(" \n")) }
  system "chmod u+x tmp/run/#{i}.sh"
end




# IMPORT POST 
def import_posts json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      topic_id = data["data"]["topic"]["id"].to_i
      p_topic_id = data["data"]["topic"]["parent"].nil? ? 0 : data["data"]["topic"]["parent"]["id"].to_i
      topic_ids = ([topic_id, p_topic_id] - [0]).compact.uniq.sort
      data["data"]["topic"]["posts"]["edges"].each do |n|
        p = n["node"]
        p_id = p["id"].to_i
        product_id = p["product"]["id"].to_i
        post = Post.find_by(id: p_id)
        if post.nil?
          post = Post.create(
            id: p_id, name: p["name"], slug: p["slug"], tagline: p["tagline"], pricing_type: p["pricingType"],
            comments: p["commentsCount"], reviews: p["product"]["reviewsWithBodyCount"].to_i,
            votes: p["votesCount"], product_id: product_id, s_created_at: p["createdAt"], topic_ids: topic_ids
          )
  
          if Product.find_by(id: product_id).nil?
            Product.create(id: product_id, slug: p["product"]["slug"])
          end
        else
          post.topic_ids = ([post.topic_ids] + topic_ids).flatten.compact.uniq.sort
          post.comments = p["commentsCount"]
          post.reviews = p["product"]["reviewsWithBodyCount"].to_i
          post.votes = p["votesCount"]
          post.save
        end
  
        if data["data"]["topic"]["posts"]["edges"].count > 0
          if fn.index("_r.1000.").to_i > 1
            if t = Topic.find_by(id: topic_id)
              t.real_posts = data["data"]["topic"]["posts"]["totalCount"].to_i
              t.save
            end
          end

          if next_cursor = data["data"]["topic"]["posts"]["pageInfo"]["endCursor"]
            fn_arr = fn.split(".")
            fn_arr[1] = (fn_arr[1].to_i + 1).to_s
            fn_arr[4] = next_cursor
            if File.file?(fn_arr.join("."))
              system "rm #{fn}" 
            end
          end
          # system "mv #{fn} #{fn.gsub(".json",".done")}"
          
        end
    rescue
    end
    
    end
  end
end


####










Dir["_data/product_hunt/posts/*.json"].sort.each do |fn|
  data = JSON.parse(File.read(fn))
  data["data"]["topic"]["posts"]["edges"].each do |p|
    id = p["node"]["id"]
    tmp_file = "_data/product_hunt/contributors/_r.#{id}.json"
    
    if !File.exist?(tmp_file) && !File.exist?(tmp_file.gsub("contributors","contributors/d"))
      puts "#{fn}_#{id} CRAWLING"
      system "_data/ContributorsByPost.sh #{id}"
      _data = JSON.parse(File.read(tmp_file))
      puts "Users: #{_data["data"]["post"]["contributors"].count}"
    else
      puts "#{fn}_#{id} SKIPPED"
    end
  end
end


data = JSON.parse(File.read("_data/product_hunt/contributors/_r.2191.json"))
data["data"]["post"]["contributors"][0]["role"]

str = []
data["data"]["post"]["contributors"].each {|n| str = str.push(n["role"]).uniq}




