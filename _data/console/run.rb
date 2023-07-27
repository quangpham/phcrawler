# gen_count, org_count, sys_count, old_count

# Todo

# Crawl posts theo ngay, GetPostsByDate
# co them post moi (va co luon product moi)
# > van de la co nhung post ko lay duoc product id

# Khi import them du lieu moi vao posts -> thay doi ve posts_count -> track them duoc theo ngay
# Khi import users -> co du lieu moi ve followers -> track duoc


# Crawl product detail, GetPostsByProduct
# (cho nhung product moi, dua theo nhung post moi duoc dang < 90 ngay)
# => crawl voters
# Crawl posts detail cho nhung post cach day 3 thang



# Recheck lai nhung users moi duoc add vao bang hunters, upvoters, vv

# Dinh ki
# crawl lai toan bo post detail
# crawl lai toan bo product detail
# crawl lai toan bo user detail

# Sau moi lan fullscan -> update lai old_count


# Side
# topic subcribers
# category
# product by category
# users' followers/following



# TODO
# Crawl subcribers qua TopicPage
# Crawl recentStacks qua TopicPage































# Buoc 6
# Tao file crawl products theo topic voi page cursor
# SPlit file ra thanh 10 files

commands = []
Topic.where("products_count > 0").each do |t|
  cursors[..(t.products_count/10+1)].each_with_index do |cursor, i|
    commands.push "./GetProductsByTopicFull.sh #{1000+i} #{t.slug} most_recent #{cursor}"
  end
end

slipt_commands_to_files(commands, 10, cursors)






# Buoc 6
# Sync len server de xu ly
# Sync nguoc file results ve local

# Buoc 7
# Import Products
#

# IMPORT PRODUCT


# import_products "/Users/quang/Downloads/done_4/"

# Buoc 8
# Manual check lai reviews(50), topics(100), posts(100)
# Crawl them nhung thanh phan con thieu


# Crawl topic's subscribers








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
            votes: p["votesCount"], product_id: product_id, org_created_at: p["createdAt"], topic_ids: topic_ids
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



















commands = []
where_str = "is_trashed is null and versions is null"
User.where(where_str).select(:id, :username, :is_trashed).each do |u|
  if u.is_trashed == false || u.is_trashed.nil?
    commands.push "./GetUserProfile.sh #{u.username}"
  end
end

Product.all.select(:id, :slug).each do |t|
  commands.push "./GetPostsByProduct.sh #{t.slug}"
end

Post.all.select(:id, :slug).each do |p|
  commands.push "./GetVotersByPost.sh #{p.slug} 100000"
end

slipt_commands_to_files(commands, 30)
