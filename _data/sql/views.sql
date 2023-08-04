CREATE VIEW user_topic_view AS
select
    pt.topic_id,
    pu.post_id,
    u.id,
    u.username,
    u.headline,
    u.twitter,
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
    u.collections_count,
    u.submitted_posts_count,
    u.stacks_count,
    u.products_count,
    u.max_streak,
    u.is_maker,
    u.is_trashed,
    u.org_created_at,
    u.created_at,
    u.activities_count,
    u.last_active_at,
    u.updated_at,
    u.gen_voted_posts_count,
    u.upvotes_score,
    u.visit_streak_score
from post_upvoter pu
inner join post_topic pt on pu.post_id=pt.post_id
inner join users u on pu.user_id=u.id;


CREATE VIEW user_topic_48 AS
select
    id,
    max(username) as username,
    count(post_id) as posts_count,
    max(headline) as headline,
    max(twitter) as twitter,
    max(website) as website,
    max(about) as about,
    max(badges) as badges,
    max(followers) as followers,
    max(following) as following,
    max(score) as score,
    max(votes_count) as votes_count,
    max(job_title) as job_title,
    max(company_name) as company_name,
    max(gen_links_count) as gen_links_count,
    max(gen_followed_topics_count) as gen_followed_topics_count,
    max(collections_count) as collections_count,
    max(submitted_posts_count) as submitted_posts_count,
    max(stacks_count) as stacks_count,
    max(products_count) as products_count,
    max(max_streak) as max_streak,
    bool_or(is_maker) as is_maker,
    bool_or(is_trashed) as is_trashed,
    max(org_created_at) as org_created_at,
    max(created_at) as created_at,
    max(activities_count) as activities_count,
    max(last_active_at) as last_active_at,
    max(updated_at) as updated_at,
    max(gen_voted_posts_count) as gen_voted_posts_count,
    max(upvotes_score) as upvotes_score,
    max(visit_streak_score) as visit_streak_score
from user_topic_view
where topic_id=48 and followers > 10 and followers < 100 and last_active_at > now() - interval '30 day'
group by id

