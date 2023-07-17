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