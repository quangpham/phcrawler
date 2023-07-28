# Lay toan posts theo product
# ./GetPostsByDateR.sh year month day cursor
# ./GetPostsByDateR.sh 2016 6 6 NjA(or blank)
# ./GetPostsByDateR.sh 2023 7 22
# Mot lan chi lan duoc max 20 posts/lan
# Cai nay lay thoai mai, nhung chi gioi han 20 de lam cho ki, contributors(limit:200) => consider lite hay full, vi du lieu nhieu

# posts(first:20 year:$year month:$month day:$day order:$order after:$cursor)
# order: DAILY_RANK, MONTHLY_RANK, VOTES

mkdir -p tmp/posts-by-date/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689730088.57.0.0; csrf_token=SrRqaV04taCy_8HZNgWHrQhXzQj8ybykKsQC6ODYZHR2AZzJ4OYjqzpG8xwmE2uogQNjE5iluow8PlAk9pMdhg; _producthunt_session_production=ceImWXpIbkJt1TGFhXkkofw3PzAvIbP8HqMLcRK%2BkXulWpIIQ14eh00VWwBGyAVouGPbj00ghkxe81cHOBodIl38oMuulZE0DSr8up367IVtmyu3mad3nAFHzswRuAXkbMb1Jv7xvij%2BYVBxqJB1DslINEV%2FKZDEiEd09DIja1Bpwu99WjBLRc6ptF9juXQuvn9iOQ7%2Box39BKWweONgF6Tnw5L%2FgKCbbB3NE89z6gRsJ5y%2BZdQUUh555MirbfkyFLo%2BLjH%2BIQ8MDNPO%2BrH8llOQxuOIfcKePY6v%2B1yU6c%2Bnbef%2FEQL9tSB0JmaNSzhAOVZpvT%2FyM1idaWYk3Q%3D%3D--o4sec7%2FEmIoRUhsB--4ubVr2dY23FuvRgKV44eOA%3D%3D' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/time-travel/2023/2/1' \
  -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest' \
  --data-raw '
  {
    "operationName":"ArchivePage","variables":{"year":'$1',"month":'$2',"day":'$3',"order":"DAILY_RANK","cursor":"'$4'"},
    "query":"query ArchivePage($year:Int$month:Int$day:Int$cursor:String$order:PostsOrder)
    {
        posts(first:20 year:$year month:$month day:$day order:$order after:$cursor)
        {
            edges
            {
                node
                {
                    id name slug tagline pricingType
                    commentsCount votesCount
                    createdAt featuredAt updatedAt
                    topics(first:100) {edges{node{id}}}
                    product { id slug }
                    contributors(limit:200) {
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
            totalCount pageInfo{endCursor hasNextPage}
        }
    }

    "}' \
  --compressed > "tmp/posts-by-date/$1.$2.$3.$4.ongoing"

mv "tmp/posts-by-date/$1.$2.$3.$4.ongoing" "tmp/posts-by-date/$1.$2.$3.$4.json"

if [ -s "tmp/posts-by-date/$1.$2.$3.$4.json" ];then
    hasNextPage=$(jq '.data.posts.pageInfo.hasNextPage' tmp/posts-by-date/$1.$2.$3.$4.json)
    if [ "$hasNextPage" = "true" ]; then
        endCursor=$(jq --raw-output '.data.posts.pageInfo.endCursor' tmp/posts-by-date/$1.$2.$3.$4.json)
        ./GetPostsByDateR.sh $1 $2 $3 $endCursor
    fi
fi


