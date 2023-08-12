CREATE VIEW user_topic_view AS
SELECT
    pt.topic_id,
    pu.post_id,
    u.id,
    u.username,
    u.headline,
    u.twitter,
    u.linkedin,
    u.website,
    u.about,
    u.badges,
    u.followers,
    u.following,
    u.score,
    u.votes_count,
    u.job_title,
    u.company_name,
    u.gen_links_count,
    u.gen_followed_topics_count,
    u.gen_voted_posts_count,
    u.collections_count,
    u.submitted_posts_count,
    u.stacks_count,
    u.products_count,
    u.upvotes_score,
    u.visit_streak_score,
    u.max_streak,
    u.is_maker,
    u.is_trashed,
    u.activities_count,
    u.last_active_at,
    u.org_created_at,
    u.created_at,
    u.updated_at
FROM post_upvoter pu
JOIN post_topic pt ON pu.post_id = pt.post_id
JOIN users u ON pu.user_id = u.id;


CREATE VIEW user_topic_48 AS
SELECT user_topic_view.id,
    max(user_topic_view.username::text) AS username,
    count(user_topic_view.post_id) AS posts_count,
    max(user_topic_view.headline::text) AS headline,
    max(user_topic_view.twitter::text) AS twitter,
    max(user_topic_view.linkedin::text) AS linkedin,
    max(user_topic_view.website::text) AS website,
    max(user_topic_view.about::text) AS about,
    max(user_topic_view.badges) AS badges,
    max(user_topic_view.job_title::text) AS job_title,
    max(user_topic_view.company_name::text) AS company_name,
    max(user_topic_view.followers) AS followers,
    max(user_topic_view.following) AS following,
    max(user_topic_view.score) AS score,
    max(user_topic_view.votes_count) AS votes_count,
    max(user_topic_view.upvotes_score) AS upvotes_score,
    max(user_topic_view.gen_links_count) AS gen_links_count,
    max(user_topic_view.gen_followed_topics_count) AS gen_followed_topics_count,
    max(user_topic_view.gen_voted_posts_count) AS gen_voted_posts_count,
    max(user_topic_view.collections_count) AS collections_count,
    max(user_topic_view.submitted_posts_count) AS submitted_posts_count,
    max(user_topic_view.stacks_count) AS stacks_count,
    max(user_topic_view.products_count) AS products_count,
    max(user_topic_view.max_streak) AS max_streak,
    max(user_topic_view.visit_streak_score) AS visit_streak_score,
    bool_or(user_topic_view.is_maker) AS is_maker,
    bool_or(user_topic_view.is_trashed) AS is_trashed,
    max(user_topic_view.activities_count) AS activities_count,
    max(user_topic_view.last_active_at) AS last_active_at,
    max(user_topic_view.org_created_at) AS org_created_at,
    max(user_topic_view.created_at) AS created_at,
    max(user_topic_view.updated_at) AS updated_at
FROM user_topic_view
WHERE user_topic_view.topic_id = 48 AND user_topic_view.followers > 10 AND user_topic_view.followers < 200 AND user_topic_view.last_active_at > (now() - '30 days'::interval)
GROUP BY user_topic_view.id;




insert into tracked_user_followings(user_id, following_id, "action")
select 5849596 as user_id, id as following_id, 'follow' as "action" from users where followers < 60 and id in (select distinct user_id from topic_subscriber where topic_id in (48) and is_subscriber=true and upvotes_count > 10) and id not in (select following_id from tracked_user_followings where user_id=5849596)
