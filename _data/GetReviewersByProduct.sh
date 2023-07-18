# Lay toan posts theo product
# ./GetReviewersByProduct.sh so-thu-tu product-name cursor
# ./GetReviewersByProduct.sh 1 acorn-protocol-2 NjA(or blank)
# Mot lan chi lan duoc max 20 posts / topic
mkdir -p tmp/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: first_visit=1689472725; first_referer=https://www.google.com/; _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; g_state={"i_p":1689479930148,"i_l":1}; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6Ijg1ZDE3NzhkLWVmNGUtNDQ4ZS1iZTk0LWFhNDdkMWVjZThiNSIsImNyZWF0ZWQiOjE2ODk1MDAwNTE0NDgsImluU2FtcGxlIjp0cnVlfQ==; _ga_WZ46833KH9=GS1.1.1689500051.5.1.1689500063.48.0.0; csrf_token=YTfwFKF6Tsfy6C--IrG7Dh_Km4VVl2vENIFiPkh8zIhdgga0HKTYzHpRHXsyp1cLlp41njH7bewiezDyXje1eg; _producthunt_session_production=LJMsfygRp9zicVCYr0GRsnnFuIBr7ct69IaqbVc1nCTQIKvzvZ95qjbB6UNsJep6EZuo0ckWOOnX1ggoAm6UC0joz%2BRdX%2BFGwr9kY7vrAwgTlnRbwEsuIrsrsXWSPNm0xxJK4CbebO8F2uixB7z%2BUeON3hR8owH5V5Yt9LBiPKLzpVphF82kOe24h%2ByRmP38KMw5To%2FecY8N6UQMEQVsBbg%2BsKDs0o8hk6X6gFIxY08EOri67CAg42H%2FGTstXcauQ9AEikgrXr%2BW16xIjzxTcVFELUpjDsmRtWr%2BZ8CK1HYVVT3DONiWAEc1r%2B%2FnwrgHfeBT1QSPSmwXWZLIcA%3D%3D--ncgV%2B3qhlEwC38%2Bo--XR4BJx%2B8dfRlkbUKuf%2FE3A%3D%3D' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/products/nfit-club-most-rewarding-way-to-get-fit' \
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
        "operationName":"ProductPageLaunches",
        "variables":{"slug":"'$2'","cursor":"'$3'"},
        "query":"query ProductPageLaunches($slug:String\u0021$cursor:String)
        {
          product(slug:$slug)
          {
            id slug name tagline logoUuid followersCount reviewsRating createdAt
            reviews(first:20 after:$cursor)
            {
              edges { 
                node {
                  id 
                  user {
                    id name username headline twitterUsername 
                    websiteUrl followersCount followingsCount 
                    isMaker isTrashed badgesCount
                    karmaBadge{score}  createdAt
                  }
                } 
              }
              totalCount pageInfo{endCursor hasNextPage}
            }
          }
        }

      "}' \
  --compressed> "tmp/_r.reviewers-by-product.$1.$2.$3.ongoing"

  mv "tmp/_r.reviewers-by-product.$1.$2.$3.ongoing" "tmp/_r.reviewers-by-product.$1.$2.$3.json"