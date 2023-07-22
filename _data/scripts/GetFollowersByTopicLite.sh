# Lay toan subs theo topic

# ./GetFollowersByTopicLite.sh $stt $topic-name $limit $cursor
# ./GetFollowersByTopicLite.sh 0 task-management 100 NjA(or blank)
# limit 20,40,60,80,100
# Lay max duoc 100 subs
# subscribers(first:100 after:$cursor)
# Lay lite info


mkdir -p tmp/followers-by-topic/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; g_state={"i_p":1690333897969,"i_l":3}; first_visit=1689900073; first_referer=; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6ImQ5MDRlYmYzLTgwZWMtNDA1Ny04YWY0LWQ2ZDU4NGYyODVlZCIsImNyZWF0ZWQiOjE2ODk5MDAwNzM0MTgsImluU2FtcGxlIjp0cnVlfQ==; analytics_session_id=1689900073443; _ga_WZ46833KH9=GS1.1.1689900073.31.1.1689900640.60.0.0; analytics_session_id.last_access=1689900641386; csrf_token=JcB6gn1G5L-lK42IulZey97so9v7PtqBP0M4waUvJK0ZdYwiwJhytC2Sv02qQLLOV7gNwJ9S3KkpuWoNs2RdXw; _producthunt_session_production=YbLfDowB1w7uN4n6AbB0QH7mKRAiv2VGw8H4HKMET4uqiZ7fpEd4f8qi6Q4TRv6p5psbOQzFgzcpzsSTjpxE1dCtGN45jyKfuylnGRIe9b%2BSA6%2Bs4RTLE35M6bPIi9Oxht%2FKcAuuBGoEkbXqWeGdMyOmrv4CZ1l%2B3qpqk4NcFyfM%2FpYdHafkqS7Dty1f5Gw4GeeAuZscWfWNlD9Dl0B6gXR3NY%2FQxH37lfrlS4ADFruyaizsGvkY4XmJUlRp8EC2XFTpuN1h2JcO0hBRcpucnx82rF53%2FmusbkQtzCSVf%2BLjljrJktGIu0kwlwObAG8FrSVPmDy3tZxP5IB1ag%3D%3D--4%2BblpKkNbjnBDVOT--AzI5SnUuKdciPVRXuBnC0A%3D%3D' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/topics/calendar' \
  -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest' \
  --data-raw $'
  {
    "operationName":"TopicPage",
    "variables":{"slug":"'$2'","cursor":"'$4'"},
    "query":"query TopicPage($slug:String\u0021$cursor:String)
    {
      topic(slug:$slug)
      {
        id parent{id}
        products{totalCount}
        subscribers(first:'$3' after:$cursor)
        {
          edges
          {
            node
            {
              id username
              name twitterUsername createdAt
              isMaker isTrashed
              followersCount followingsCount badgesCount
              productsCount collectionsCount votesCount
              submittedPostsCount stacksCount

              karmaBadge {score}
              visitStreak { duration }
              work {id jobTitle companyName product{id} }
              followedTopics { edges {node { id } } }
              submittedPosts { edges { node{id} } }

              activityEvents(first:1)
              {
                edges { node { id occurredAt } }
                totalCount
              }

            }
          }
          totalCount pageInfo{endCursor hasNextPage}
        }
      }
    }

  "}' \
--compressed> "tmp/followers-by-topic/$1.$2.$3.$4.ongoing"

mv "tmp/followers-by-topic/$1.$2.$3.$4.ongoing" "tmp/followers-by-topic/$1.$2.$3.$4.json"
