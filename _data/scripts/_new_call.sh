# Product Categories / ProductCategoryConnection
# Trang chu, menu category

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
#   --data-raw '{"operationName":"DesktopHeaderCategoriesNav","variables":{},"query":"query DesktopHeaderCategoriesNav{productCategories(visibleOnly:true parentOnly:true order:subcategories_count_desc){edges{node{id description displayName name path subCategories{edges{node{id displayName name path __typename}__typename}__typename}__typename}__typename}__typename}}"}' \
#   --compressed

# ProductCategoryPage
# Get products by category
# https://www.producthunt.com/categories/ad-blockers?order=most_recent
# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; csrf_token=CstI-WewS8qm5KT-jALmTGsDb4irCvpvX5i4biRfnwo2fr5Z2m7dwS5dljucFApJ4lfBk89m_EdJYuqiMhTm-A; _producthunt_session_production=6dpD7s1%2FldHzRg3JH%2FTOJulY7GtohgTACzOxt4PqRyKmX5fL2F%2BdfH86cJYUVCj5U4VICgKMWpICvkzJWU7NAkDxFEgvb3zpySLY5uE6g3Ha10sXU4Q%2F8oJE5q3BYeNI%2Fj5kv9LRJK5akCbCMKIITIqdJRwPBPY8jDw7O1UigpB4d0JI43nbgfiblnL2am%2FHvlPMhxG0lZ0%2FsDqrj4nV6acexucfoUS6K6jr6GIjtgKDYNgldRM6Yf88Brr0OpY%2BqieZkI1%2BmVC19Z9xb0D69Dr9wXHRe1n96hg0Sph57HN7vuq3AKjZlIxo7hG%2F8DbsuZEkirhpVqE0IdfNZw%3D%3D--OcvUFpn%2FQnBzbLVn--m%2Fuuh68on%2FCagD8I1PkC1A%3D%3D; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689730712.35.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/categories/ad-blockers?order=most_recent' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'{"operationName":"ProductCategoryPage","variables":{"slug":"ad-blockers","cursor":"MTA","order":"most_recent"},"query":"query ProductCategoryPage($slug:String\u0021$cursor:String$order:CategoryProductsOrder\u0021){productCategory(slug:$slug){id description displayName name path parent{id name path __typename}meta{title description __typename}topProducts:products(first:8 order:best_rated){edges{node{id name ...ProductThumbnailFragment __typename}__typename}__typename}targetedAd(kind:\\"feed\\"){id ...AdFragment __typename}...ProductCategoryPageProductListFragment ...CategorySidebarCategoryListFragment ...CategorySidebarNewestProductsFragment __typename}sidebarAd:ad(kind:\\"sidebar\\"){id ...AdFragment __typename}}fragment ProductCategoryPageProductListFragment on ProductCategory{id products(first:10 after:$cursor order:$order){edges{node{id description reviewsCount reviewsRating slug stackers(first:3){edges{node{id ...UserCircleListFragment __typename}__typename}totalCount __typename}websiteUrl ...ProductThumbnailFragment ...ProductStackButtonFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}__typename}fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}fragment ProductStackButtonFragment on Product{id name isStacked stacksCount __typename}fragment UserCircleListFragment on User{id ...UserImage __typename}fragment UserImage on User{id name username avatarUrl __typename}fragment CategorySidebarCategoryListFragment on ProductCategory{id name displayName parent{id ...CategorySidebarCategoryListItemFragment subCategories(first:20){edges{node{id ...CategorySidebarCategoryListItemFragment __typename}__typename}__typename}__typename}subCategories(first:20){edges{node{id ...CategorySidebarCategoryListItemFragment __typename}__typename}__typename}__typename}fragment CategorySidebarCategoryListItemFragment on ProductCategory{id name displayName path __typename}fragment CategorySidebarNewestProductsFragment on ProductCategory{id name displayName newestProducts:products(first:3 order:most_recent){edges{node{id name tagline reviewsRating slug ...ProductThumbnailFragment __typename}__typename}__typename}__typename}fragment AdFragment on Ad{id subject post{id slug name updatedAt commentsCount topics(first:1){edges{node{id name __typename}__typename}__typename}...PostVoteButtonFragment __typename}ctaText name tagline thumbnailUuid url __typename}fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}"}' \
#   --compressed

# TopicsIndexPage
# Lay toan bo topic, cai nay co roi
# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; csrf_token=id21edsnUWd3_6g7_Uan0Wnp3Gct6jriUrcZiZapwW-1aEPZZvnHbP9Gmv7tUEvU4L1yfEmGPMpETUtFgOK4nQ; _producthunt_session_production=mW5eUm%2FXp1UTcMiijrroMqtyvK%2BTycZpweaRrSgOXEVCe%2FaeT5ZrDuZ%2F6fz6Me4h%2Fbum3poQ3P4qaWYfK8tT78rqqKizAWrRLex03BFePRyh4HQjOx41weuNJXm12xK5HF2Q79ijybhXZ1WwRrOOKkW4tQfNntqBkqc1QHEdxvcu5Ity9RPwYze1ngzrnvngpAPT8p4HgTDIIK8385k3x%2BzWorkvgGnbM%2FORNQABQoXzy8Ki4Vz3HWgfiFvIXtEdPmkELoDeVeiu0bpW0Z7k0%2BIGngZpXetrnh%2BANQQLW%2BK1joPW6As4vQxFVI0p5TD%2BE%2FRYbiA4Ay9wARYMoQ%3D%3D--K%2BWesj2z08rIfBMt--k2t4WcYKiNCzLeuTKG9j8g%3D%3D; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689729857.60.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/topics?ref=header_nav' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw '{"operationName":"TopicsIndexPage","variables":{"query":null,"cursor":"MjA"},"query":"query TopicsIndexPage($query:String$cursor:String){trendingTopics:topics(query:$query first:6 filter:\"trending\"){edges{node{id ...TopicsPageTopicItemFragment __typename}__typename}__typename}...RecentReviewsQueryFragment topics(query:$query first:20 after:$cursor order:\"name\"){edges{node{id ...TopicsPageTopicItemFragment __typename}__typename}totalCount pageInfo{endCursor hasNextPage __typename}__typename}}fragment TopicsPageTopicItemFragment on Topic{id name slug description ...TopicImage ...TopicFollowButtonFragment __typename}fragment TopicImage on Topic{name imageUuid __typename}fragment TopicFollowButtonFragment on Topic{id slug name isFollowed followersCount ...TopicImage __typename}fragment RecentReviewsQueryFragment on Query{topicsRecentReviews(first:4){edges{node{id ...ReviewActivityItemFragment __typename}__typename}__typename}__typename}fragment ReviewActivityItemFragment on Review{id path overallExperience rating createdAt ...RatingReviewActionBarFragment user{id name ...UserImage __typename}product{id name path slug tagline ...ProductThumbnailFragment ...ReviewStarRatingCTAFragment __typename}__typename}fragment UserImage on User{id name username avatarUrl __typename}fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}fragment ReviewStarRatingCTAFragment on Product{id slug name isMaker reviewsRating __typename}fragment RatingReviewActionBarFragment on Review{id createdAt hasVoted votesCount ...ReviewDeleteButtonFragment ...RatingReviewShareButtonFragment ...RatingReviewEditButtonFragment ...RatingReviewReportButtonFragment ...RatingReviewReplyButtonFragment __typename}fragment ReviewDeleteButtonFragment on Review{id canDestroy rating __typename}fragment RatingReviewShareButtonFragment on Review{id url user{id name __typename}__typename}fragment RatingReviewEditButtonFragment on Review{id canUpdate product{id name slug __typename}__typename}fragment RatingReviewReportButtonFragment on Review{id __typename}fragment RatingReviewReplyButtonFragment on Review{id product{id isMaker __typename}__typename}"}' \
#   --compressed  > "tmp/TopicsIndexPage.json"


# ArchivePage
# Tra ve posts the ngay thang
# https://www.producthunt.com/time-travel/2022/3/1

# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689730088.57.0.0; csrf_token=SrRqaV04taCy_8HZNgWHrQhXzQj8ybykKsQC6ODYZHR2AZzJ4OYjqzpG8xwmE2uogQNjE5iluow8PlAk9pMdhg; _producthunt_session_production=ceImWXpIbkJt1TGFhXkkofw3PzAvIbP8HqMLcRK%2BkXulWpIIQ14eh00VWwBGyAVouGPbj00ghkxe81cHOBodIl38oMuulZE0DSr8up367IVtmyu3mad3nAFHzswRuAXkbMb1Jv7xvij%2BYVBxqJB1DslINEV%2FKZDEiEd09DIja1Bpwu99WjBLRc6ptF9juXQuvn9iOQ7%2Box39BKWweONgF6Tnw5L%2FgKCbbB3NE89z6gRsJ5y%2BZdQUUh555MirbfkyFLo%2BLjH%2BIQ8MDNPO%2BrH8llOQxuOIfcKePY6v%2B1yU6c%2Bnbef%2FEQL9tSB0JmaNSzhAOVZpvT%2FyM1idaWYk3Q%3D%3D--o4sec7%2FEmIoRUhsB--4ubVr2dY23FuvRgKV44eOA%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/time-travel/2023/2/1' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw '{"operationName":"ArchivePage","variables":{"year":2023,"month":7,"day":18,"order":"DAILY_RANK","cursor":null},"query":"query ArchivePage($year:Int$month:Int$day:Int$cursor:String$order:PostsOrder){posts(first:20 year:$year month:$month day:$day order:$order after:$cursor){edges{node{id ...PostItemList __typename}__typename}totalCount pageInfo{endCursor hasNextPage __typename}__typename}}fragment PostItemList on Post{id ...PostItem __typename}fragment PostItem on Post{id commentsCount name shortenedUrl slug tagline updatedAt pricingType topics(first:1){edges{node{id name slug __typename}__typename}__typename}redirectToProduct{id slug __typename}...PostThumbnail ...PostVoteButton __typename}fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}fragment PostStatusIcons on Post{id name productState __typename}fragment PostVoteButton on Post{id featuredAt updatedAt createdAt disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}"}' \
#   --compressed > "tmp/ArchivePage.json"

# VisitStreaksPage
# https://www.producthunt.com/visit-streaks?ref=header_nav
# Lay users streaks nhieu?? Nhung users active nhat

# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; csrf_token=bh5wYugWo60j10MubKMLn_Sf52L1Ky_PHnq2C-0ND41Sq4bCVcg1pqtucet8teeafctJeZFHKecIgOTH-0Z2fw; _producthunt_session_production=H5kMUHDa6UF6TrQMX8JZMHKYRaFeYWSODXYbpvral7gRC27g7R3vB%2BGXa3%2FFbmKcthFHWiMEtd2AtrghrrVhH0%2F8EwHIUa166EyVxzsdK1kj9GAW34mhrpoK41tC6CpOkih2QxheZeVGeNMLe29hIT26G9M2n6GavmimktV0d8%2BuGZ1gU3ZDBi7uLq7U8un0L6vKOy6kMr9TiBlmhL%2FnJyeLVD%2BsAI6rem4rQhW3O6IQHIFZn9pPoGVnKleNfhYLwm7Wu9JJYprCIV4xw9EA24HSXkJgAjb1OzmDTKOUo7gkuxXxUn5YhpgHuRv%2BdX9SrA%2Bn8xpRLsVN2kXwDg%3D%3D--HKtF9iWd0QPz5oNt--pMWUNQml1YmNdCxLPxKfTA%3D%3D; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689731140.60.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/visit-streaks?ref=header_nav' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw '{"operationName":"VisitStreaksPage","variables":{"cursor":"MjA"},"query":"query VisitStreaksPage($cursor:String){visitStreaks(first:20 after:$cursor){edges{node{id ...VisitStreakItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}}fragment VisitStreakItemFragment on VisitStreak{id duration emoji user{id name ...UserImage ...UserFollowButtonFragment __typename}__typename}fragment UserImage on User{id name username avatarUrl __typename}fragment UserFollowButtonFragment on User{id followersCount isFollowed __typename}"}' \
#   --compressed

# CollectionsIndexPage
# Lay nhung collections cua users
# https://www.producthunt.com/collections?ref=header_nav

# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; csrf_token=MUffUWpDgIgB3naaF1MBmMUxUudaIGMvhYaB-_42SLAN8inx150Wg4lnRF8HRe2dTGX8_D5MZQeTfNM36H0xQg; _producthunt_session_production=z6Q3wW4GtELSraaq4qxrQvn1j5V7r35hIsKIZlT7tIyhQ0wOrowklzj3iOpDjwU3lCbg4TXNa7GYkOYV6wc4TB%2BdlAunbKe7ShCQqjmAXWH7evMWYhva2AzDDVye9mTFdqlIyUTO8ClpHwavaaQM7BAOiP7MlonJvi2uZGk%2FzcOoK1OYINP1gEC9ZQd%2B3XmlCAVME6dSO9Nmrlrwi9cnQ2Bn6U5tfRO%2F%2F1SavF4z9eOH5SXyuqNx8fh%2F2qPb9HiqvueKAM7woMxaecU3U8OH4ebVp6Btok8HBfzArPQ6ATdABJAnoMSU%2FVuGptK%2Bhzgc7BXB69oWHre%2F1HTUdA%3D%3D--4RSF%2FI3RMylhTcS8--tDPLj2sfOxU9VoG3WBz68Q%3D%3D; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689731273.29.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/collections?ref=header_nav' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'{"operationName":"CollectionsIndexPage","variables":{"query":"","cursor":"MTI","isSearch":false},"query":"query CollectionsIndexPage($query:String$cursor:String$isSearch:Boolean\u0021){collections(featured:true first:12 after:$cursor)@skip(if:$isSearch){...CollectionsGridFragment __typename}collectionSearch(query:$query first:12 after:$cursor)@include(if:$isSearch){...CollectionsGridFragment __typename}}fragment CollectionsGridFragment on CollectionConnection{edges{node{id ...CollectionCardFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}fragment CollectionCardFragment on Collection{id name title description path productsCount products(first:3){edges{node{id name ...ProductThumbnailFragment __typename}__typename}__typename}user{id name username ...UserImage __typename}__typename}fragment UserImage on User{id name username avatarUrl __typename}fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}"}' \
#   --compressed


# https://www.producthunt.com/@tinaciousz/collections/10-useful-linkedin-tools
# Collection detail
# ProfileCollectionShowPage

# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; _ga_WZ46833KH9=GS1.1.1689729091.15.1.1689731281.21.0.0; csrf_token=9xuRUtewbCeKRD7r3FPIx4ncgCmtEYS-G9oAlkUXouHLrmfyam76LAL9DC7MRSTCAIguMsl9gpYNIFJaU1zbEw; _producthunt_session_production=bdYOxRZDu4A4YDN1hJ2K86ASdnL6r9vkgu1HO4XTPtd5bTsQpfdSUXbMHL7Xl4lsnM0veC%2FEdIkFyWy6BIi0NMMePys%2BmY%2Fgh8a8JyxNw86yxdCGLu%2BFugEJhNvhaWqe5kjcJLrWvlRkhVAv2ZGrKj%2FTH2NC9hNZpkxoA6WwDdrDoaTW1lKG0eq%2BkTyP832EHkj18JuX9%2F3F6Tetizc3aLqebgnQVDvqs%2BTjYVi9VuQa%2FOaj2Z70eY9N63sRofY5gP8Uo4A7Ux3oafcTJTKRdWId7f3jaZ5oAfer228XXfg5YwPDsIIjyI%2Btu9QC%2Blj5BLKUTTdpUQz%2BkE24Qg%3D%3D--GrCiDE6BT7k7jJ03--OFO4toEW0uaqtpTrLbcU%2Bg%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/collections?ref=header_nav' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'{"operationName":"ProfileCollectionShowPage","variables":{"slug":"10-useful-linkedin-tools","username":"tinaciousz","cursor":null},"query":"query ProfileCollectionShowPage($slug:String\u0021$username:String$cursor:String){collection(slug:$slug username:$username){id slug name description canEdit personal user{id name ...UserImage ...UserFollowButtonFragment __typename}products(first:20 after:$cursor liveFirst:true){edges{node{id ...CollectionProductItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}...AlternativeProductsSidebarCardFragment ...MetaTags __typename}}fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}fragment UserImage on User{id name username avatarUrl __typename}fragment UserFollowButtonFragment on User{id followersCount isFollowed __typename}fragment CollectionProductItemFragment on Product{id slug name description logoUuid reviewsCount isNoLongerOnline ...CollectionAddButtonFragment ...ProductThumbnailFragment ...ReviewStarRatingCTAFragment __typename}fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}fragment CollectionAddButtonFragment on Product{id name description ...ProductItemFragment __typename}fragment ProductItemFragment on Product{id slug name tagline followersCount reviewsCount topics(first:2){edges{node{id slug name __typename}__typename}__typename}...ProductFollowButtonFragment ...ProductThumbnailFragment ...ProductMuteButtonFragment ...FacebookShareButtonV6Fragment ...ReviewStarRatingCTAFragment __typename}fragment ProductFollowButtonFragment on Product{id followersCount isSubscribed __typename}fragment ProductMuteButtonFragment on Product{id isMuted __typename}fragment FacebookShareButtonV6Fragment on Shareable{id url __typename}fragment ReviewStarRatingCTAFragment on Product{id slug name isMaker reviewsRating __typename}fragment AlternativeProductsSidebarCardFragment on Collection{id name slug alternativeProducts(take:5){id ...AlternativeProductsCardProductItemFragment __typename}targetedAd(kind:\\"sidebar\\"){...AdFragment __typename}__typename}fragment AdFragment on Ad{id subject post{id slug name updatedAt commentsCount topics(first:1){edges{node{id name __typename}__typename}__typename}...PostVoteButtonFragment __typename}ctaText name tagline thumbnailUuid url __typename}fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}fragment AlternativeProductsCardProductItemFragment on Product{id slug name tagline ...ProductThumbnailFragment __typename}"}' \
#   --compressed

# JobsPage
# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; _hjSession_3508551=eyJpZCI6ImM2ZWEzMmI4LTYyNjgtNDdhNS05YzQzLTMyMjBiYTU0MmY5YSIsImNyZWF0ZWQiOjE2ODk3MjkwOTIxNDYsImluU2FtcGxlIjpmYWxzZX0=; g_state={"i_p":1690333897969,"i_l":3}; csrf_token=AWJY9Ro83oDLntCZ6TxvhM9QSXhfn9dEb-25WoFabms9165Vp-JIi0Mn4lz5KoOBRgTnYzvz0Wx5F-uWlxEXmQ; _producthunt_session_production=QCyRPkmf7Frn22wQ9d9wvgVwd29J5L9vhmU%2BZhaLzQV6t76AV%2Br6xV7E6yvtzmCfmfBjWSi3nNccW87fGmm84SrcQUxF4pgJIBKAAuZcXvqevdZE8VjzWo8bRScfnN4S2VHl6nuWjrZKN7HrcB4AmkvDG2CH%2BKOGj%2B32Uygvzd787vjmzWBvLSugx1xwHBiu77TOpPHT%2BMq0xG5lBTFS1YPq67EG2I9paE5psJrREzBfLK9bQ5%2BpVJvKZxWNTMLZ%2FAXWjz4FsvsE2WUOpNPvd94Gv4smF5onalhqGep%2FY4hcno5dpnppkazX4%2FqJZHxkV5aVG%2BvFvGJ6y0wjqA%3D%3D--dHPzgropiGtRCZyP--69G2yZcGTIEqA28hJo9jXQ%3D%3D; _ga_WZ46833KH9=GS1.1.1689733498.16.0.1689733498.60.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/jobs?&' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'{"operationName":"JobsPage","variables":{"categories":[],"locations":[],"remote_ok":false,"cursor":"MjA"},"query":"query JobsPage($cursor:String$query:String$locations:[String\u0021]$categories:[String\u0021]$remote_ok:Boolean){jobBoard(query:$query locations:$locations categories:$categories remoteOk:$remote_ok order:RENEWAL kind:INHOUSE){jobsCount availableLocations isSubscribed jobs(first:20 after:$cursor){edges{node{id ...JobBoardItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}__typename}}fragment JobBoardItemFragment on Job{id token companyName imageUuid jobTitle kind slug locations categories url remoteOk __typename}"}' \
#   --compressed
