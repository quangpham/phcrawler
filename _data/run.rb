# Init tmp
def init_tmp
  system "mkdir -p tmp/run/ && rm -R tmp/run/ && mkdir -p tmp/run/"
  system "cp _data/PostByTopic.sh tmp/run/PostByTopic.sh"
  system "cp _data/ContributorsByPost.sh tmp/run/ContributorsByPost.sh"
  system "touch tmp/run/run.sh && chmod u+x tmp/run/run.sh"
end

# CRAWL TOPICS
tmp_file = "tmp/_r.json"
order = "name" # "trending"

system "_data/Topic.sh 1001 #{order}"

for i in 2..10000 # Khoang 21 page / "endCursor": "NDIw",
  if File.exist?(tmp_file)
    raw_data = File.read(tmp_file)
    data = JSON.parse(raw_data)
    next_cursor = data["data"]["topics"]["pageInfo"]["endCursor"]
    if !next_cursor.blank?
      system "_data/Topic.sh #{1000+i} #{order} #{next_cursor}"
    else
      break
    end
  else 
    break
  end
end
###

# IMPORT TOPICS
Dir["tmp/_r.*.json"].sort.each do |fn|
  begin
    data = JSON.parse(File.read(fn))
    
    data["data"]["topics"]["edges"].each do |n|
      t = n["node"]
      topic = Topic.find_or_initialize_by(id: t["id"].to_i)
      topic.name = t["name"]
      topic.slug = t["slug"]
      topic.posts_count = t["postsCount"]
      topic.followers_count = t["followersCount"]
      if t["parent"]
        parent = Topic.find_or_create_by(id: t["parent"]["id"].to_i)
        topic.parent_id = parent.id
      end
      topic.save
      if data["data"]["topics"]["edges"].count > 0
        system "mv #{fn} #{fn.gsub(".json",".done")}"
      end
  rescue
  end

  end
end







# CRAWL POSTS


def crawl_posts(_topic)
  topic = _topic || "task-management" # "productivity"
  tmp_file = "tmp/_r.json"
  order = "by-date" # "most-upvoted"
  
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


# Crawl Voters
init_tmp()
p_ids = Post.where("((old_votes is null) OR (old_votes is not null and votes!=old_votes)) AND votes < 13000").collect {|p| p.slug}

run_content_str = ""
p_ids.each_slice(p_ids.count/10).to_a.each_with_index do |arr, i|
  str = ""
  arr.each {|id| str= str + "./ContributorsByPost.sh #{id} 100000\n"}
  File.open("tmp/run/#{i}.sh", 'w') { |file| file.write(str) }
  system "chmod u+x tmp/run/#{i}.sh"
  run_content_str += "\n./#{i}.sh & \n"
end
File.open("tmp/run/run.sh", 'w') { |file| file.write(run_content_str) }




###

# Import Voters
# {
#   "data": {
#     "post": {
#       "id": "14306",
#       "contributors": [
#         {
#           "role": "hunter",


def import_voters json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].sort.each do |fn|
    puts fn
    begin
      data = JSON.parse(File.read(fn))
      post_id = data["data"]["post"]["id"].to_i
      hunter_ids = []
      maker_ids = []
      commenter_ids = []
      upvoter_ids = []
      data["data"]["post"]["contributors"].each do |n|
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
        user.created_at = u["createdAt"]    
        hunter_ids.push(user_id) if !n["role"].index("hunter").nil?
        maker_ids.push(user_id) if !n["role"].index("maker").nil?
        commenter_ids.push(user_id) if !n["role"].index("commenter").nil?
        upvoter_ids.push(user_id) if !n["role"].index("upvoter").nil?
        user.save
      end
    
      if data["data"]["post"]["contributors"].count > 0
        if post = Post.find_by(id: post_id)
          post.old_votes = post.votes
          post.hunter_ids = ([] + [post.hunter_ids] + hunter_ids).flatten.uniq.compact.sort
          post.maker_ids = ([] + [post.maker_ids] + maker_ids).flatten.uniq.compact.sort
          post.commenter_ids = ([] + [post.commenter_ids] + commenter_ids).flatten.uniq.compact.sort
          post.upvoter_ids = ([] + [post.upvoter_ids] + upvoter_ids).flatten.uniq.compact.sort
          post.save
        end
        system "rm #{fn}"
        # system "mv #{fn} #{fn.gsub(".json",".rone")}"
      end
    rescue
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




