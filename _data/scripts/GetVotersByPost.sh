# ./GetVotersByPost.sh post-slug limit
# ./GetVotersByPost.sh startup-stash 100000

# Get voters (contributors) thoai mai
# Get them thong tin cho post: votesCount commentsCount updatedAt topic_ids
# Chua lay duoc product_id

mkdir -p tmp/voters-by-post/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: ajs_anonymous_id=%225aef8a05-4030-4127-89e7-1d831c4fd000%22; _ga=GA1.2.355219814.1658400138; visitor_id=ff77a19e-2a2c-42bd-9e94-5a2d2656df6e; track_code=ac988993a0; intercom-id-fe4ce68d4a8352909f553b276994db414d33a55c=84095e66-11f4-4d8b-9775-79655cc1a8a0; intercom-session-fe4ce68d4a8352909f553b276994db414d33a55c=; agreed_cookie_policy=2022-07-21+03%3A42%3A44+-0700; _gid=GA1.2.1110914128.1658636171; g_state={"i_p":1658722573206,"i_l":2}; ajs_user_id=%224452508%22; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221658400138043%22}%2C%22_delighted_lst%22:{%22t%22:%221658744163017%22%2C%22m%22:{%22token%22:%22mHQZ28ZqcpG77POvrubgCe8M%22}}%2C%22_delighted_lrt%22:{%22t%22:%221658802497710%22%2C%22m%22:{%22token%22:%22mHQZ28ZqcpG77POvrubgCe8M%22}}}}; first_visit=1658881208; first_referer=; csrf_token=ztUTDIJXtzdum3vEI3qGu2%2FZY0Yg0nwq78qmi9myffBg%2BniFojZNG8ZmSlVmEn41yU0ddKdnN1Gv4XNddp4rFA%3D%3D; _producthunt_session_production=mD%2BwrSJvND6UbuETF0l6D9CEw3vEvVW4v8nvFoD0A2dQz%2B%2BUcM5ZLR%2BkO4Kb6zyP6WNdN0F2Jrc9%2Fxh33%2Fw%2FyKAEYUmkXLP0y0N17q6m3QHBZxHy0IJbaYWR9SGZF%2Fd3fO4IFrLRstwxc5hYGjcqnpgMRyDIu3xROh%2FtC1Ue4l%2FoANy5QdaXqdCOc7TZGMmfuNIrYSovQ1d0od5SoeY0oeLYh6Xxcjxdz1MunoVRKf1XyOHd6DVmbunUr4bKcNEpc7MmK05HMndqnvyKj8scSpMsnoRhmQD8esqsaiacIWC0PJ%2BcGn0pozEJFpqtroI5zwouBqDZWkz1qD321nvvpn8HN8eS8HZpGzbqpav%2BxfXLFga5lu4fqpVQrXoa--613rA6HQ%2FOsNh4Bq--9Eq8XWYYGiH2yrTrI3bSmA%3D%3D' \
  -H 'dnt: 1' \
  -H 'newrelic: eyJ2IjpbMCwxXSwiZCI6eyJ0eSI6IkJyb3dzZXIiLCJhYyI6IjE4NjQxMTMiLCJhcCI6IjU5NDMzNzgyMiIsImlkIjoiY2UyNjM2OTVmNjBkZmZjOCIsInRyIjoiYTczNTI4NTk0M2QwNmQwZWEyMTUzMjg3YjEyOTlmNWQiLCJ0aSI6MTY1ODg5MDk5NTA0NH19' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/topics' \
  -H 'sec-ch-ua: ".Not/A)Brand";v="99", "Google Chrome";v="103", "Chromium";v="103"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'traceparent: 00-a735285943d06d0ea2153287b1299f5d-ce263695f60dffc8-01' \
  -H 'tracestate: 1864113@nr=0-1-1864113-594337822-ce263695f60dffc8----1658890995044' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest' \
  --data-raw $'
  {
  "operationName":"PostPageSocialProof",
  "variables":{"postId":"'$1'","limit":'$2'},
  "query":"query PostPageSocialProof($postId:ID\u0021$limit:Int\u0021)
    {
      post(id:$postId)
      {

        id name slug tagline pricingType
        commentsCount votesCount
        createdAt featuredAt updatedAt
        product{id slug}
        topics(first:100){ edges{node{id}} }
        contributors(limit:$limit)
        {
          role
          user {
            id name username headline twitterUsername
            websiteUrl followersCount followingsCount
            isMaker isTrashed badgesCount
            karmaBadge{score} createdAt
          }
        }
      }
    }

    "
  }
    ' \
  --compressed > "tmp/voters-by-post/$1.ongoing"

mv "tmp/voters-by-post/$1.ongoing" "tmp/voters-by-post/$1.json"
