# ./GetVisitStreaks.sh cursor
# ./GetVisitStreaks.sh NjA(or blank)
# Lay max duoc 100 thang

# VisitStreaksPage
# https://www.producthunt.com/visit-streaks?ref=header_nav
# Lay users streaks nhieu?? Nhung users active nhat

mkdir -p tmp/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; csrf_token=bh5wYugWo60j10MubKMLn_Sf52L1Ky_PHnq2C-0ND41Sq4bCVcg1pqtucet8teeafctJeZFHKecIgOTH-0Z2fw; _producthunt_session_production=H5kMUHDa6UF6TrQMX8JZMHKYRaFeYWSODXYbpvral7gRC27g7R3vB%2BGXa3%2FFbmKcthFHWiMEtd2AtrghrrVhH0%2F8EwHIUa166EyVxzsdK1kj9GAW34mhrpoK41tC6CpOkih2QxheZeVGeNMLe29hIT26G9M2n6GavmimktV0d8%2BuGZ1gU3ZDBi7uLq7U8un0L6vKOy6kMr9TiBlmhL%2FnJyeLVD%2BsAI6rem4rQhW3O6IQHIFZn9pPoGVnKleNfhYLwm7Wu9JJYprCIV4xw9EA24HSXkJgAjb1OzmDTKOUo7gkuxXxUn5YhpgHuRv%2BdX9SrA%2Bn8xpRLsVN2kXwDg%3D%3D--HKtF9iWd0QPz5oNt--pMWUNQml1YmNdCxLPxKfTA%3D%3D; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689731140.60.0.0' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/visit-streaks?ref=header_nav' \
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
    "operationName":"VisitStreaksPage","variables":{"cursor":"'$1'"},
    "query":"query VisitStreaksPage($cursor:String)
    {
      visitStreaks(first:100 after:$cursor)
      {
        edges
        {
          node
          {
            id duration
            user
            {
              id name username headline twitterUsername
              websiteUrl followersCount followingsCount
              isMaker isTrashed badgesCount
              about productsCount

              karmaBadge{score} createdAt
              work { id jobTitle companyName product { id } }
              links { id name url kind }
              badgeGroups{ awardKind badgesCount}
              followedTopics { edges {node { id } } }
            }
          }
        }
        totalCount pageInfo{endCursor hasNextPage}
      }
    }
  "}' \
  --compressed > "tmp/_r.visit_streaks.$1.ongoing"

mv "tmp/_r.visit_streaks.$1.ongoing" "tmp/_r.visit_streaks.$1.json"
