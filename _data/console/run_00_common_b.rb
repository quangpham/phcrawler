

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

  insert into product_topic(product_id, topic_id)
  select id,unnest(topic_ids) as topic_id from products where topic_ids is not null and topic_ids != '{}'
  ON CONFLICT (product_id, topic_id) DO NOTHING;

  insert into product_post(product_id, post_id)
  select id,unnest(post_ids) as post_id from products where post_ids is not null and post_ids != '{}'
  ON CONFLICT (product_id, post_id) DO NOTHING;


  insert into user_followers(user_id, follower_id)
  select id,unnest(follower_ids) as follower_id from users where follower_ids is not null and follower_ids != '{}'
  ON CONFLICT (user_id, follower_id) DO NOTHING;

  insert into user_followings(user_id, following_id)
  select id,unnest(following_ids) as following_id from users where following_ids is not null and following_ids != '{}'
  ON CONFLICT (user_id, following_id) DO NOTHING;


  insert into tracked_user_followers(user_id, follower_id)
  select user_id, follower_id from user_followers where user_id in (select id from users where is_tracked=true)
  ON CONFLICT (user_id, follower_id) DO NOTHING;

  insert into tracked_user_followings(user_id, following_id)
  select user_id, following_id from user_followings where user_id in (select id from users where is_tracked=true)
  ON CONFLICT (user_id, following_id) DO NOTHING;

  UPDATE users u set last_active_at=GREATEST(u.last_active_at, t.last_active_at)
  from (
    select user_id, max(org_created_at) as last_active_at
    from (
      select pu.post_id,pu.user_id,p.org_created_at from post_upvoter pu
      inner join posts p on pu.post_id=p.id
      where pu.post_id in (select id from posts where org_created_at > now() - interval '360 day')
    ) t1
    group by user_id
  ) t
  where u.id = t.user_id;

  update users u set gen_reviews_count=t.reviews_count
  from (
      select user_id,count(product_id) as reviews_count from product_reviewer
      group by user_id
  ) t
  where u.id = t.user_id;




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

  # insert into product_reviewer(product_id, user_id)
  # select id,unnest(reviewers_ids) as user_id from products where reviewers_ids is not null and reviewers_ids != '{}'
  # ON CONFLICT (product_id, user_id) DO NOTHING;








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

  --- update sys_posts_count cho post_archives
  update post_archives set sys_posts_count=t2.posts_count, post_ids=t2.post_ids
  from (
    select sys_created_at,count(id) as posts_count, ARRAY_AGG(id) as post_ids from (
      select id,DATE(org_created_at) sys_created_at from posts where org_created_at is not null
    ) t
    group by sys_created_at
  ) t2
  where post_archives.sys_created_at = t2.sys_created_at;
'


update_last_active_at = '

update users t1 set last_active_at=GREATEST(t1.last_active_at, t2.last_active_at)
from (
	select user_id,max(org_created_at) as last_active_at
	from user_collections
	group by user_id
) t2
where t1.id = t2.user_id;

update users t1 set last_active_at=GREATEST(t1.last_active_at, t2.last_active_at)
from (
	select user_id,max(created_at) as last_active_at
	from product_reviewer
	group by user_id
) t2
where t1.id = t2.user_id;

'

update_sql = '
CREATE TABLE _tmp (user_id int4,topic_id int4,post_id int4);

insert into _tmp(user_id,topic_id,post_id)
select pu.user_id,pt.topic_id,pu.post_id
from post_upvoter pu
inner join post_topic pt on pt.post_id=pu.post_id
where pt.topic_id=00000;

insert into topic_subscriber(user_id,topic_id) select user_id,topic_id from _tmp on CONFLICT(user_id, topic_id) DO NOTHING;

update topic_subscriber set upvotes_count=t.upvotes_count
from (select user_id,topic_id,count(post_id) as upvotes_count from _tmp group by user_id,topic_id) t
where topic_subscriber.user_id=t.user_id and topic_subscriber.topic_id=t.topic_id;

drop table _tmp;
'


Topic.order(:id).each do |t|
  ActiveRecord::Base.connection.execute(update_sql.gsub("00000", "#{t.id}"))
end
