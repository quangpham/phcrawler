# ./Topic.sh 1 NjA(or blank)
# stt, order ("posts_count", "name", "trending") , cursor


mkdir -p tmp/
rm tmp/topics.json*

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: ajs_anonymous_id=%225aef8a05-4030-4127-89e7-1d831c4fd000%22; _ga=GA1.2.355219814.1658400138; visitor_id=ff77a19e-2a2c-42bd-9e94-5a2d2656df6e; track_code=ac988993a0; intercom-id-fe4ce68d4a8352909f553b276994db414d33a55c=84095e66-11f4-4d8b-9775-79655cc1a8a0; intercom-session-fe4ce68d4a8352909f553b276994db414d33a55c=; agreed_cookie_policy=2022-07-21+03%3A42%3A44+-0700; _gid=GA1.2.1110914128.1658636171; g_state={"i_p":1658722573206,"i_l":2}; ajs_user_id=%224452508%22; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221658400138043%22}%2C%22_delighted_lst%22:{%22t%22:%221658744163017%22%2C%22m%22:{%22token%22:%22mHQZ28ZqcpG77POvrubgCe8M%22}}%2C%22_delighted_lrt%22:{%22t%22:%221658802497710%22%2C%22m%22:{%22token%22:%22mHQZ28ZqcpG77POvrubgCe8M%22}}}}; first_visit=1658881208; first_referer=; _gat=1; csrf_token=web4dyFNxsrH1ZeSj1t9xK6k3XkvxYofDvEgzeBLPSNvyZP%2BASw85m8opgPKM4VKCDCjS6hwwWRO2vUbT2drxw%3D%3D; _producthunt_session_production=Vi6oEfck9pkAQuKPZBKCjqwRSCzeq8ly3GVZmv274%2FlYdps1opdwMTaKhVTSSqA3XC8SxI6%2Fud89Uxa7fFRxO%2BCaS2dGayhANAFEK68quBGrR27qAPOtaKjXinW5IGeCUBWdk3M4lqNKsT6i9s8KwHZRjkHdw3ZCzQkT8HTsiTWWjf%2FHE%2B%2F5GFbODmPoMw%2FcIBe0IPe%2FWO4LYMFR1avW0w0ZqaNd5LNnhwSnnrVDJ7vjMxjq%2Fp1GRiJmr%2BmvpuXn9ba559jQQ2vbn3Tms9ze1x2A5mlRA7sdA4NZ4mXx7dBY%2BU2iHSQHnVrVkTGyNRRQ8CLFeEPmJkVo39uT%2FAAJ9qFY6%2FTaECADSwmZgljYTJR97PCP%2F0c3G8Oc2Ujb5NKt%2BuAcLPMmvUiIm3PU5JmspO3rZ5qWvMpAbHJNo9FVudrUTe31oWdikR677hYcSR4l8K963fM%3D--UVy1H1CtLyinXbsv--MTd9s1LUAiCHQlAYC5gKRA%3D%3D' \
  -H 'dnt: 1' \
  -H 'newrelic: eyJ2IjpbMCwxXSwiZCI6eyJ0eSI6IkJyb3dzZXIiLCJhYyI6IjE4NjQxMTMiLCJhcCI6IjU5NDMzNzgyMiIsImlkIjoiMTE0OTFiZDk1N2FhZmQ0MCIsInRyIjoiZmU3MTBmZjFlODcwMjQ2Nzc5MWNlZWZjZDlhYzU4M2UiLCJ0aSI6MTY1ODg5NDk1ODMwNX19' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/topics' \
  -H 'sec-ch-ua: ".Not/A)Brand";v="99", "Google Chrome";v="103", "Chromium";v="103"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'traceparent: 00-fe710ff1e8702467791ceefcd9ac583e-11491bd957aafd40-01' \
  -H 'tracestate: 1864113@nr=0-1-1864113-594337822-11491bd957aafd40----1658894958305' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest' \
  --data-raw '
  {
    "operationName":"TopicsPage",
    "variables":{"query":null,"cursor":"","order":"name"},
    "query":"query TopicsPage($cursor:String$query:String$order:String)
    {
      topics(query:$query first:5000 after:$cursor order:$order)
      {
        edges
        {
          node
            {
              id name slug parent{id name slug} followersCount postsCount 
              recentStacks(first:1){totalCount}
              products(first:1){totalCount}
              posts(first:1){totalCount}
            }
        }
        totalCount pageInfo{endCursor hasNextPage}
      }
    }"
  }' \
  --compressed > tmp/topics.json

# topics(query:$query first:2 after:$cursor order:$order)
# subscribers(first:1){totalCount} // vi subscribers tuong duong followersCount
