# Lay toan posts theo product
# ./GetPostsByProduct.sh so-thu-tu product-name cursor
# ./GetPostsByProduct.sh 1 itch-io NjA(or blank)
# Mot lan chi lan duoc max 10 products
# products(first:20 after:$cursor order:$order)
# order: most_recent, most_followed, best_rated

mkdir -p tmp/


curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _ga_WZ46833KH9=GS1.1.1689868314.28.0.1689868314.60.0.0; csrf_token=eHJ0tkepVy5gcM9TTCi-ze__z3jbDBNiDM4JkUIL6v1Ex4IW-nfBJejJ_ZZcPlLIZqthY79gFUoaNFtdVECTDw; _producthunt_session_production=k6z64f%2FinMITbtlyw5iZJtpV8wepoCklrgxU3dx5cQoGxbn1xUiVvfWwfZGMyBizBA%2FPANRkrxAS7sSHp098C16mvmrHs4ZYy6febKF9jxAm9VtpYcJ4MOVrLLkRhrJXFk5LiInWmo%2FqsZ5WyoRYN7rFfZpVM9t4bXBqSv1ltorWqpo0jwfAskXoY38%2FJv06sbh%2BaI131AttcoBbe5vsv6NyFRp3RrpfiIh5lfU5AAjUxF9MLYbnrLyZLsp8LSLnHmTyH%2FTKn8TwA5MrcD85%2FY%2B8hD1Bs5O0StzdU0o%2Bs8V3IR2oVK%2BZ6SfR%2FDQALnIl5kN4hc1JFJUduH3YMw%3D%3D--u9ahz5AB8FmCICX0--3TwkdBXE4oWAcCb3BEqdWg%3D%3D' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/categories/calendars' \
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
    "operationName":"ProductCategoryPage",
    "variables":{"slug":"work-productivity","cursor":"MjA","order":"most_recent"},
    "query":"query ProductCategoryPage($slug:String\u0021$cursor:String$order:CategoryProductsOrder\u0021)
    {
      productCategory(slug:$slug)
      {
        id path parent{ id }
        products(first:20 after:$cursor order:$order)
        {
            edges {
              node {
                id
              }
            }
            totalCount
        }
      }
    }

  "}' \
  --compressed  > "tmp/test.json"


# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; _producthunt_session_production=Ql0XCGY3aga6S58WLk4Nrht7pQM%2BNd5Zxy4V2tJ2EHG7MbBcrz93jWg9nmt06keDCKeVmAE0BxilO%2FY4%2B3Wl248gTnfCV6MkqSNJ6Z5%2B0ZYqZsbST8nxoImRlfkYbulxEcEYmjvjurSARwyruCcNZwhIdFK1mOx937gfivpymTTx%2FoUOD9pFjCFEKp6RmD0aph1MgIpjuoJgeLnJ9zqwOC1cCjLfkupdqikadTHtrLF2DH3v4HxeT8WSnufH5RngLOTORKGeWaOG1F2aIpOeyibxPDXubf3xKgEqQaf41f4CaksrcYZLUMrUndG6H4CbmBBIvAKmS%2Fw1RNqbPQ%3D%3D--7headZmjQS%2BdQZSz--d9dp4lfnHF59tjidfU8o%2BQ%3D%3D; csrf_token=koi3ET4Dejl5Uk0Rf0YBtsOWeaI97bp1hknPtPjjJWCuPUGxg93sMvHrf9RvUO2zSsLXuVmBvF2Qs5147qhckg; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689729744.60.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/categories/shopify-apps' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw '
#   {
#     "operationName":"DesktopHeaderCategoriesNav",
#     "variables":{},
#     "query":"query DesktopHeaderCategoriesNav{productCategories(visibleOnly:true parentOnly:true order:subcategories_count_desc){edges{node{id description displayName name path subCategories{edges{node{id displayName name path __typename}__typename}__typename}__typename}__typename}__typename}}"}' \
#   --compressed  > "tmp/test.json"
