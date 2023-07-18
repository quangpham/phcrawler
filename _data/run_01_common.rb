# Buoc 1
# Init tmp

def init_tmp
  system "mkdir -p tmp/run/ && rm -R tmp/run/ && mkdir -p tmp/run/"
  system "cp _data/GetTopicDetail.sh tmp/run/GetTopicDetail.sh"
  system "cp _data/GetProductsByTopic.sh tmp/run/GetProductsByTopic.sh"
  system "cp _data/ContributorsByPost.sh tmp/run/ContributorsByPost.sh"
  system "cp _data/GetPostsByProduct.sh tmp/run/GetPostsByProduct.sh"
  system "cp _data/GetReviewersByProduct.sh tmp/run/GetReviewersByProduct.sh"
  system "touch tmp/run/run.sh && chmod u+x tmp/run/run.sh"
end

cursors = File.read("_data/cursors.txt").split(",")

def slipt_commands_to_files commands, number_split_files = 15, cursors
  init_tmp()
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

  system "cd tmp/ && zip -r run.zip run/"
end


sql = '

  insert into post_hunter(post_id, user_id)
  select id, unnest(hunter_ids) as user_id from posts where hunter_ids is not null and hunter_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_maker(post_id, user_id)
  select id, unnest(maker_ids) as user_id from posts where maker_ids is not null and maker_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_upvoter(post_id, user_id)
  select id, unnest(upvoter_ids) as user_id from posts where upvoter_ids is not null and upvoter_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_commenter(post_id, user_id)
  select id, unnest(commenter_ids) as user_id from posts where commenter_ids is not null and commenter_ids != '{}'
  ON CONFLICT (post_id, user_id) DO NOTHING;

  insert into post_topic(post_id, topic_id)
  select id,unnest(topic_ids) as topic_id from posts where topic_ids is not null and topic_ids != '{}'
  ON CONFLICT (post_id, topic_id) DO NOTHING;

  insert into product_reviewer(product_id, user_id)
  select id,unnest(reviewers_ids) as user_id from products where reviewers_ids is not null and reviewers_ids != '{}'
  ON CONFLICT (product_id, user_id) DO NOTHING;

  insert into product_topic(product_id, topic_id)
  select id,unnest(topic_ids) as topic_id from products where topic_ids is not null and topic_ids != '{}'
  ON CONFLICT (product_id, topic_id) DO NOTHING;

  insert into product_post(product_id, post_id)
  select id,unnest(post_ids) as post_id from products where post_ids is not null and post_ids != '{}'
  ON CONFLICT (product_id, post_id) DO NOTHING;

  update products p set sys_posts_count=t.posts_count
  from (
    select product_id,count(id) as posts_count from posts
    group by product_id
  ) t
  where p.id = t.product_id;

  update products p set sys_reviews_count=t.reviews_count
  from (
      select product_id,count(user_id) as reviews_count from product_reviewer
      group by product_id
  ) t
  where p.id = t.product_id;

  update posts p set sys_votes_count=t.votes_count
  from (
      select post_id,count(user_id) as votes_count from post_upvoter
      group by post_id
  ) t
  where p.id = t.post_id;

  update topics tp set sys_posts_count=t.posts_count
  from (
      select topic_id,count(post_id) as posts_count from post_topic
      group by topic_id
  ) t
  where tp.id = t.topic_id;

'
