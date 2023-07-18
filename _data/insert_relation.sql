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


-- Update sys_posts_count cho Products cho nhung thang nao co posts_count > 20
update products p set sys_posts_count=t.sys_posts_count
from (
	select product_id,count(id) as sys_posts_count from posts
	where product_id in (select id from products where posts_count > 20)
	group by product_id
) t
where p.id = t.product_id;

update products p set sys_reviews_count=t.sys_reviews_count
from (
	select product_id,count(user_id) as sys_reviews_count from product_reviewer
	where product_id in (select id from products where reviews_count > 20)
	group by product_id
) t
where p.id = t.product_id;

