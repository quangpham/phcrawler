mkdir -p tmp/followers-by-user/

# tag=$( tail -n 1 foo.txt )
# echo $tag
# sed -i '' -e '$ d' foo.txt

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; g_state={"i_p":1690333897969,"i_l":3}; first_visit=1689900073; first_referer=; intercom-id-fe4ce68d4a8352909f553b276994db414d33a55c=9b1cea8e-8b49-401d-a6f3-03c332bc7a32; intercom-session-fe4ce68d4a8352909f553b276994db414d33a55c=; intercom-device-id-fe4ce68d4a8352909f553b276994db414d33a55c=a1170b41-86ea-429f-a666-3f0cdcfe28fa; _ga_WZ46833KH9=GS1.1.1690766889.53.0.1690766889.60.0.0; analytics_session_id=1690766889469; analytics_session_id.last_access=1690766889470; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6IjlhNzZkZTQxLTA2MzUtNDg2MC04NzI0LTg5OWI4MjcxMzFkNiIsImNyZWF0ZWQiOjE2OTA3NjY4ODk0ODQsImluU2FtcGxlIjp0cnVlfQ==; csrf_token=TfBKmUOL4rIydyLPSB2sRFLsZg9Jrp1XdYK8YmeAYsFxRbw5_lV0ubrOEApYC0BB27jIFC3Cm39jeO6uccsbMw; _producthunt_session_production=kpfdrDDIK4hv6W34RNXCNDJqCAVdnv%2F4XpE8ExIkHul4mQtMvonutwaNcseNKYKgwqYMIyxUMMGkhZ5ZmIM2FPrJGe8Ui59lxTBxfb7xpTMLB1vF%2BhXjLxEyJr5ypminy9427aL8ctEhtvGfH%2BegnXACFz9IEm4L92nlMkRkEtoenGfBCHh9HN%2BYPeY9rauVBLqRfaplPDwgZnA02ULVBM0uYBZvkwWCxGFqY8ZbteoCWiElkXD3tlbvImj79DsAPy3QP00VUda0JuB%2FjI0HRMaRtcr4olRx6xB%2FbJmdvnO1p%2FeIPym7ByFcV8yZx%2B13zbkpJYV%2FaUAMMkTl8A%3D%3D--kLfVYRxCMdbLanZV--6uM2LRvEHr%2BTdR73VLTmpQ%3D%3D' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/@pxq85/following' \
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
    "operationName":"ProfileFollowingQuery",
    "variables":{"username":"'$1'","cursor":"'$2'","query":""},
    "query":"query ProfileFollowingQuery($username:String\u0021$cursor:String)
    {
      profile:user(username:$username)
      {
        id isTrashed username followingsCount
        following(first:20 after:$cursor)
        {
          edges
          {
            node
            {
              id name username headline twitterUsername
              websiteUrl followersCount followingsCount
              isMaker isTrashed badgesCount
              karmaBadge{score} createdAt
            }
            __typename
          }
          totalCount pageInfo{endCursor hasNextPage}
        }

      }
    }
    "
  }' \
  --compressed > tmp/followers-by-user/$1.$2.json

if [ -s "tmp/followers-by-user/$1.$2.json" ];then
  hasNextPage=$(jq '.data.profile.following.pageInfo.hasNextPage' tmp/followers-by-user/$1.$2.json)
  if [ "$hasNextPage" = "true" ]; then
      endCursor=$(jq --raw-output '.data.profile.following.pageInfo.endCursor' tmp/followers-by-user/$1.$2.json)
      ./GetFollowersByUserR.rb $1 $endCursor
  fi
fi
