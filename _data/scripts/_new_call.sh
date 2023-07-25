# Todo

# Crawl posts theo ngay, co them post moi (va co luon product moi)
# > van de la co nhung post ko lay duoc product id


# Crawl Recent products -> thuc chat la crawl post moi (ma co theo thong tin product)
# crawl lai tiep nhu product gan day nhat


# Crawl product detail (cho nhung product moi)
# => crawl voters
# Crawl posts detail cho nhung post cach day 3 thang


# Recheck lai nhung users moi duoc add vao bang hunters, upvoters, vv

# Dinh ki
# crawl lai toan bo post detail
# crawl lai toan bo product detail
# crawl lai toan bo user detail


# Side
# topic subcribers
# category
# product by category
# users' followers/following






scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@159.223.83.131:/root/
scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@167.99.74.30:/root/


ssh root@159.223.83.131 'ls -1 run/tmp/voters-by-post/ | wc -l'
ssh root@167.99.74.30 'ls -1 run/tmp/voters-by-post/ | wc -l'

ssh root@159.223.83.131 "cd /root/run/ && mkdir done_05_a && find tmp/voters-by-post/ -name '*.json' -exec mv -t done_05_a/ {} + && zip -r done_05_a.zip done_05_a/"
scp root@159.223.83.131:/root/run/done_05_a.zip /Users/quang/Downloads/ok/voters-by-post/

ssh root@167.99.74.30 "cd /root/run/ && mkdir done_05_b && find tmp/voters-by-post/ -name '*.json' -exec mv -t done_05_b/ {} + && zip -r done_05_b.zip done_05_b/"
scp root@167.99.74.30:/root/run/done_05_b.zip /Users/quang/Downloads/ok/voters-by-post/

scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@159.223.83.131:/root/a.zip
ssh root@159.223.83.131 'cd /root/ && rm -rf run* && unzip a.zip '

scp /Users/quang/Projects/upbase/phcrawler/tmp/run.zip root@167.99.74.30:/root/a.zip
ssh root@167.99.74.30 'cd /root/ && rm -rf run* && unzip a.zip'

# Lay thong tin cua topic
# Trong do co thong tin cua subscribers

mkdir tmp/

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
    "variables":{"slug":"productivity","cursor":null,"topPostsVariant":"THIS_WEEK","order":"best_rated"},
    "query":"query TopicPage($slug:String\u0021$cursor:String$order:ProductsOrder\u0021){topic(slug:$slug)
    {
        id slug parent{id name slug __typename}
        ...MetaTags
        ...TopicPageHeaderFragment
        ...TopicPageProductListFragment
        ...TopicPageProductQuestionsFragment
        ...TopReviewedProductsCardFragment
        targetedAd(kind:\\"feed\\"){...AdFragment __typename}
        subscribers(first:50){edges{node{id ...UserGridCardFragment __typename}__typename}__typename}
        recentStacks(first:3){edges{node{id ...TopicPageRecentStackFragment __typename}__typename}__typename}__typename
    }
    viewer{id ...TopicsNewsletterCardFragment __typename}
    }
    fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}
    fragment AdFragment on Ad{id subject post{id slug name updatedAt commentsCount topics(first:1){edges{node{id name __typename}__typename}__typename}...PostVoteButtonFragment __typename}ctaText name tagline thumbnailUuid url __typename}
    fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}
    fragment TopicPageHeaderFragment on Topic{id name description parent{id name slug __typename}...TopicFollowButtonFragment __typename}
    fragment TopicFollowButtonFragment on Topic{id slug name isFollowed followersCount ...TopicImage __typename}
    fragment TopicImage on Topic{name imageUuid __typename}
    fragment TopicPageProductListFragment on Topic{id name slug products(first:10 after:$cursor order:$order excludeHidden:true){edges{node{id ...ReviewCTAPromptFragment ...ProductItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}__typename}
    fragment ProductItemFragment on Product{id slug name tagline followersCount reviewsCount topics(first:2){edges{node{id slug name __typename}__typename}__typename}...ProductFollowButtonFragment ...ProductThumbnailFragment ...ProductMuteButtonFragment ...FacebookShareButtonV6Fragment ...ReviewStarRatingCTAFragment __typename}
    fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}
    fragment ProductFollowButtonFragment on Product{id followersCount isSubscribed __typename}
    fragment ProductMuteButtonFragment on Product{id isMuted __typename}
    fragment FacebookShareButtonV6Fragment on Shareable{id url __typename}
    fragment ReviewStarRatingCTAFragment on Product{id slug name isMaker reviewsRating __typename}
    fragment ReviewCTAPromptFragment on Product{id isMaker viewerReview{id __typename}...ReviewCTASharePromptFragment __typename}
    fragment ReviewCTASharePromptFragment on Product{id name tagline slug ...ProductThumbnailFragment ...FacebookShareButtonFragment __typename}
    fragment FacebookShareButtonFragment on Shareable{id url __typename}
    fragment TopReviewedProductsCardFragment on Topic{id topReviewedProducts(first:4){edges{node{id name tagline reviewsRating slug path ...ProductThumbnailFragment ...ReviewStarRatingCTAFragment reviewSnippet{id overallExperience user{id ...UserImage __typename}__typename}__typename}__typename}__typename}__typename}
    fragment UserImage on User{id name username avatarUrl __typename}
    fragment UserGridCardFragment on User{id ...UserImage __typename}
    fragment TopicsNewsletterCardFragment on Viewer{id settings{sendAiEmail sendProductivityEmail __typename}__typename}
    fragment TopicPageRecentStackFragment on ProductStack{id user{id name username isTrashed ...UserImage __typename}product{id name tagline slug ...ProductThumbnailFragment __typename}__typename}
    fragment TopicPageProductQuestionsFragment on Topic{productQuestions(first:1 filter:NOT_ANSWERED excludeSkipped:true){edges{node{id path title ...ProductQuestionAnswerFlowFragment ...ProductQuestionAnswerPromptFragment ...ProductQuestionShareButtonFragment ...ProductQuestionReviewFlowFragment __typename}__typename}__typename}__typename}
    fragment ProductQuestionAnswerFlowFragment on ProductQuestion{id slug path viewerAnswer{id product{id isMaker viewerReview{id __typename}...ReviewFormProductFragment __typename}__typename}__typename}
    fragment ReviewFormProductFragment on Product{id name slug isMaker isSubscribed isStacked reviewsRating reviewsCount reviewsWithBodyCount reviewsWithRatingCount ratingSpecificCount{rating count __typename}viewerReview{id __typename}__typename}
    fragment ProductQuestionReviewFlowFragment on ProductQuestion{id placeholder viewerAnswer{id product{id name viewerReview{id __typename}__typename}__typename}__typename}
    fragment ProductQuestionAnswerPromptFragment on ProductQuestion{id path canViewAnswers answerAuthors(first:3){edges{node{id ...UserCircleListFragment __typename}__typename}totalCount __typename}__typename}
    fragment UserCircleListFragment on User{id ...UserImage __typename}
    fragment ProductQuestionShareButtonFragment on ProductQuestion{id ...FacebookShareButtonV6Fragment __typename}
"}' \
  --compressed > tmp/TopicPage.json


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

# Get new/recent launches
# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: first_visit=1689472725; first_referer=https://www.google.com/; _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; g_state={"i_p":1689677615026,"i_l":2}; _hjIncludedInSessionSample_3508551=0; _hjSession_3508551=eyJpZCI6IjcyOTRlZDcxLWJkYTctNGYwNy1iNDdlLWZmMGU1MWFiZTY4NCIsImNyZWF0ZWQiOjE2ODk2NDAxNjI4MDQsImluU2FtcGxlIjpmYWxzZX0=; _ga_WZ46833KH9=GS1.1.1689640161.11.1.1689640242.60.0.0; csrf_token=0nn4Vt4zMsEmqm8gDr5FWG-aZHQGzVXVAZ5PlvwdP4zuzA72Y-2kyq4TXeUeqKld5s7Kb2KhU_0XZB1a6lZGfg; _producthunt_session_production=CrEbK1SaNFcg8J8VoB2gvQv5mjKKA0d7tEd42jKaK3bI7chchcMOwLmSChdjVmB98CePid5O%2FcUBnT467aXrtJ5m71In8L8WVvW%2BoJRXKpIm2DUqrKSEjrEiapVeed0fX25LiHOftM%2F8rvc2BWO%2FLEZiBOeiAU0Khz8GnfjlD3dCVBY64CjpWkqI0SOkJzG45iyS0WivKeRqHtU36OhcOPcWIptuo%2FG7fSstlac848P3Fv2tSw7gT0CLEOS9bn846xgHImq%2FUVoVThVeCUwRuD1AOa6HtsxazXSqDg6VH%2FfIit%2BW%2Bdtp65RDwHrUtVhY2Q%2FSzFyzlht9shSq3g%3D%3D--uIvGjZwkCwWCuwgE--eovR7zWFTLHX8818DDldHg%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/all' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'{"operationName":"HomePage","variables":{"cursor":"0-117","kind":"ALL","filters":{}},"query":"query HomePage($cursor:String$kind:HomefeedKindEnum\u0021$filters:HomefeedFiltersInput\u0021){homefeed(after:$cursor kind:$kind filters:$filters){kind edges{node{id title subtitle hideAfter date randomization items{...on Post{id hideVotesCount ...PostItemFragment featuredComment{id body:bodyText user{id ...UserImage __typename}__typename}__typename}...on DiscussionThread{id ...DiscussionHomepageItemFragment __typename}...on AnthologiesStory{id ...StoryHomepageItemFragment __typename}...on Ad{id ...AdFragment __typename}...on Collection{id ...CollectionHomepageItemFragment __typename}__typename}...ComingSoonCardHomepageFragment __typename}__typename}pageInfo{hasNextPage endCursor __typename}__typename}mainBanner:banner(position:MAINFEED){id description url desktopImageUuid wideImageUuid tabletImageUuid mobileImageUuid __typename}phHomepageOgImageUrl viewer{id showHomepageOnboarding __typename}}fragment AdFragment on Ad{id subject post{id slug name updatedAt commentsCount topics(first:1){edges{node{id name __typename}__typename}__typename}...PostVoteButtonFragment __typename}ctaText name tagline thumbnailUuid url __typename}fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}fragment PostItemFragment on Post{id commentsCount name shortenedUrl slug tagline updatedAt pricingType topics(first:1){edges{node{id name slug __typename}__typename}__typename}redirectToProduct{id slug __typename}...PostThumbnail ...PostVoteButtonFragment __typename}fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}fragment PostStatusIcons on Post{id name productState __typename}fragment UserImage on User{id name username avatarUrl __typename}fragment DiscussionHomepageItemFragment on DiscussionThread{id title descriptionText slug commentsCount user{id firstName username avatarUrl name headline isMaker isViewer badgesCount badgesUniqueCount karmaBadge{kind score __typename}__typename}discussionCategory:category{id name slug __typename}...DiscussionThreadItemVote __typename}fragment DiscussionThreadItemVote on DiscussionThread{id hasVoted votesCount __typename}fragment StoryHomepageItemFragment on AnthologiesStory{id slug title description minsToRead commentsCount ...StoryVoteButtonFragment storyCategory:category{name slug __typename}author{id username firstName avatarUrl name headline isMaker isViewer badgesCount badgesUniqueCount karmaBadge{kind score __typename}__typename}__typename}fragment StoryVoteButtonFragment on AnthologiesStory{id hasVoted votesCount __typename}fragment CollectionHomepageItemFragment on Collection{id slug name collectionTitle:title description user{id name username __typename}...CollectionsThumbnailsFragment __typename}fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}fragment CollectionsThumbnailsFragment on Collection{products(first:1){edges{node{id ...ProductThumbnailFragment __typename}__typename}__typename}__typename}fragment ComingSoonCardHomepageFragment on HomefeedPage{comingSoon{id ...UpcomingEventItemFragment __typename}__typename}fragment UpcomingEventItemFragment on UpcomingEvent{id title truncatedDescription isSubscribed post{id createdAt __typename}product{id slug postsCount followersCount followers(first:3 order:popularity excludeViewer:true){edges{node{id ...UserCircleListFragment __typename}__typename}__typename}...ProductItemFragment __typename}...FacebookShareButtonV6Fragment __typename}fragment ProductItemFragment on Product{id slug name tagline followersCount reviewsCount topics(first:2){edges{node{id slug name __typename}__typename}__typename}...ProductFollowButtonFragment ...ProductThumbnailFragment ...ProductMuteButtonFragment ...FacebookShareButtonV6Fragment ...ReviewStarRatingCTAFragment __typename}fragment ProductFollowButtonFragment on Product{id followersCount isSubscribed __typename}fragment ProductMuteButtonFragment on Product{id isMuted __typename}fragment FacebookShareButtonV6Fragment on Shareable{id url __typename}fragment ReviewStarRatingCTAFragment on Product{id slug name isMaker reviewsRating __typename}fragment UserCircleListFragment on User{id ...UserImage __typename}"}' \
#   --compressed


# Profile About
# https://www.producthunt.com/@jesv
# co the lay linkedin => Nam trong links

# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; _hjSession_3508551=eyJpZCI6ImU5YmNhMjkzLWI5ZTctNDY2NC1iNmNiLTc0MmE3Yjk0NzdlOCIsImNyZWF0ZWQiOjE2ODk3NTQ3NTQxNjAsImluU2FtcGxlIjpmYWxzZX0=; _ga_WZ46833KH9=GS1.1.1689754754.18.1.1689755019.21.0.0; csrf_token=su6BbS8ndrrD-K4XlMR--uEhydjUaUKO4mwKoSwrP0GOW3fNkvngsUtBnNKE0pL_aHVnw7AFRKb0llhtOmBGsw; _producthunt_session_production=r6M8aUFswoOLauKDN3L8CXd6dGe%2FeufqxHzRc8qGwHjsGpIvLkFCASgrfsccirURo0UawaiHGL%2Bi%2Fy7oOMxCHGCPHqHV%2FpEJ80AI1VhDRCduAKACSRNnUrk30CM4XuzL1kSi%2BIamwgZc5tCUfi6AhHkUi2tPiAx6w5jHCORR5sS00RSSPO4bs220e41L%2FfXV3UC32mKUDkoz79bfz6m91tFO7e82xbXetihL0uACiaRLrkqivvYVmta16fCXr0zNvHjta%2BHhfqh0jGI8Skgq4MzFiT6Rae65Gnir%2BKgRTsU9Px9u7ULDZEBzgxeGghvt7d22XG5NK63BOBGp8A%3D%3D--ma7WFX0zeDKxtIaW--T%2FiUjFwjbgZbOjQFAzCrxQ%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/@jesv/activity' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'{"operationName":"ProfileAboutPage","variables":{"username":"jesv","newProductsCursor":null},"query":"query ProfileAboutPage($username:String\u0021$newProductsCursor:String){profile:user(username:$username){id name username about badgesCount badgesUniqueCount productsCount votesCount createdAt links{...ProfileAboutUserLinkFragment __typename}followedTopics{edges{node{id name slug __typename}__typename}__typename}badgeGroups{awardKind badgesCount award{id name description imageUuid active __typename}__typename}votedPosts(first:8){edges{node{id ...PostItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}newProducts(first:5 after:$newProductsCursor){edges{node{id ...MakerHistoryItemFragment __typename}__typename}pageInfo{startCursor endCursor hasNextPage __typename}__typename}...JobTitleFragment ...MetaTags __typename}}fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}fragment PostItemFragment on Post{id commentsCount name shortenedUrl slug tagline updatedAt pricingType topics(first:1){edges{node{id name slug __typename}__typename}__typename}redirectToProduct{id slug __typename}...PostThumbnail ...PostVoteButtonFragment __typename}fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}fragment PostStatusIcons on Post{id name productState __typename}fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}fragment ProfileAboutUserLinkFragment on UserLink{id name encodedUrl kind __typename}fragment MakerHistoryItemFragment on Product{id name createdAt tagline createdAt slug ...ProductThumbnailFragment makerPosts(madeBy:$username){edges{node{id name tagline thumbnailImageUuid createdAt slug __typename}__typename}__typename}__typename}fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}fragment JobTitleFragment on User{id work{id jobTitle companyName product{id name slug __typename}__typename}__typename}"}' \
#   --compressed


# Get User Collections

# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjSession_3508551=eyJpZCI6ImRkOWI4ZDBjLWJjZGUtNDlhNC04MmFmLTg0ZTgwOWM0MWI5ZCIsImNyZWF0ZWQiOjE2ODk4MjEwNDMyMTcsImluU2FtcGxlIjpmYWxzZX0=; csrf_token=llHqAN8rnmDSeJihUkiHSixydLEvYX3CR0bHhB1FgS2q5BygYvUIa1rBqmRCXmtPpSbaqksNe-pRvJVICw743w; _producthunt_session_production=jzhHNZF6ClzAgKc7W16guXkH35mTXUiodauCZoIDppP%2BbsoOXzsq%2BKJHs6qkjw7gsa2NOC%2BUeDTue32w77LhcXcj70wzChrwPtrQ8jy3BfjllCGoUzpG9zBw4nW5Xz2o7qoJWLRn4t4unVJkkMODDnsJDoZo75dXNUJDQE%2FMHxGSwg81mUXrroq7UfGiwtgI9wrPlpZ93XQdVGh5Vy%2BSKBfQOBlw8B1rWUmJjclvUUwd1sYi%2FqX9E%2BdKQt5%2FbBo5q9BuhDCzMWDcnyW%2B8culsdl4I2SASPl9RU7OyXNPn2FS2tvnTxJwm5ZiheKuG2ecM0uVmTQjNQBy6yMH1A%3D%3D--vWaRE15KtNJqi4Wf--udy2Abty%2FVt%2F9F53znRxaw%3D%3D; _ga_WZ46833KH9=GS1.1.1689821043.20.1.1689822106.17.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/@tinaciousz/collections' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'
#   {
#     "operationName":"ProfileHuntedPage",
#     "variables":{"username":"tinaciousz"},
#     "query":"query ProfileHuntedPage($cursor:String$username:String\u0021$query:String)
#     {
#       profile:user(username:$username)
#       {
#         id submittedPosts(first:20 after:$cursor query:$query){edges{node{id ...PostItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}...MetaTags __typename}}fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}fragment PostItemFragment on Post{id commentsCount name shortenedUrl slug tagline updatedAt pricingType topics(first:1){edges{node{id name slug __typename}__typename}__typename}redirectToProduct{id slug __typename}...PostThumbnail ...PostVoteButtonFragment __typename}fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}fragment PostStatusIcons on Post{id name productState __typename}fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}"}' \
#   --compressed


# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjSession_3508551=eyJpZCI6ImRkOWI4ZDBjLWJjZGUtNDlhNC04MmFmLTg0ZTgwOWM0MWI5ZCIsImNyZWF0ZWQiOjE2ODk4MjEwNDMyMTcsImluU2FtcGxlIjpmYWxzZX0=; _hjIncludedInSessionSample_3508551=0; _ga_WZ46833KH9=GS1.1.1689821043.20.1.1689822085.38.0.0; csrf_token=PPNm0LrOFd259Qpk_EyBJb6mQ0ZWVtcCbaLMSpQKeRwARpBwBxCD1jFMOKHsWm0gN_LtXTI60Sp7WJ6GgkEA7g; _producthunt_session_production=Jwq%2BKll%2B%2Biew8yO2fC33maM3abFmUrYsU9tUf%2BhBuyhv6IiWoG%2BwlAjFGkaBrGCbcb7V8hrlOnoJpz%2BDUZpm7Zu18Ua1oP9%2BD1UgBN3hGrj6Z%2B4VuQzHkuY8%2B30KWMhwmJ64qgXYgJhO3D9W2iM5yqQvmgdvGjEsi6EYju%2B7qh3pqrhctEAjg4GhsXRnmDXcwBhC4VGkvwXn9MVMU%2BmS%2BLYkyugmsyk%2BrC7PnPyY4B%2B33vF%2FeWBnF42OvVM8mPPYy1qKT2JAMqcoIOU6e5gcA%2B2jlj2Eak5KQi%2F9N%2FAWH8Gc42FDq51rpLGOVvX8pSx3BTdWUHgUB4yETANQtA%3D%3D--2hGxjhljhDEao3j2--OYE2MB200Aq3FaDmEGBeIg%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/@tinaciousz/collections/10-useful-linkedin-tools' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'
#   {
#     "operationName":"ProfileCollectionsIndexPage",
#     "variables":{"username":"tinaciousz"},
#     "query":"query ProfileCollectionsIndexPage($username:String\u0021$cursor:String)
#     {
#       profile:user(username:$username)
#       {
#         id
#         collections(first:6 after:$cursor)
#         {
#           ...CollectionsGridFragment __typename
#         }
#         ...MetaTags __typename
#       }
#     }

#   fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}


#   fragment CollectionsGridFragment on CollectionConnection
#   {
#     edges
#     {
#       node {  id ...CollectionCardFragment __typename}__typename

#     }
#     pageInfo {endCursor hasNextPage}
#   }

#   fragment CollectionCardFragment on Collection
#   {
#     id name title description path productsCount
#     products(first:3){
#       edges{node{id name ...ProductThumbnailFragment __typename}__typename}__typename}user{id name username ...UserImage __typename}__typename}

#   fragment UserImage on User{id name username avatarUrl __typename}
#   fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}"}' \
#   --compressed > "test.json"


# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjSession_3508551=eyJpZCI6ImRkOWI4ZDBjLWJjZGUtNDlhNC04MmFmLTg0ZTgwOWM0MWI5ZCIsImNyZWF0ZWQiOjE2ODk4MjEwNDMyMTcsImluU2FtcGxlIjpmYWxzZX0=; _hjIncludedInSessionSample_3508551=0; _ga_WZ46833KH9=GS1.1.1689821043.20.1.1689822085.38.0.0; csrf_token=ccTDTXmubZaJgHnsDFKBfTmV-fA-k8WAGPGMk8IzM2dNcTXtxHD7nQE5SykcRG14sMFX61r_w6gOC95f1HhKlQ; _producthunt_session_production=ifAErzs%2FrrKcvBQIqdVq3DO8v5ztTnaGOW6oqHXJFyQY%2BvXidWmetiOJoB8ugnmFTvekBpb1%2FSN%2FqD2WU%2BUwpRmZeUkiuKCYiUp3DaAclMUUTsgwKP12rUZTnmwspTsAEjWmrGjRMAXtjLAykDnJTxLwOMSluUQzHIf9lXGMzxVe4su13aeuJWPS%2Bdt8wsD0DJr%2B4OgyqHADOFw9fQMLC2VPnA%2F0FFuUcxeUxjiTLcmix5Zy%2FHid1LNcB7ccda4XXOiX%2BOvoGVgV3sghgsE7YDJltNOGy89aOdjaslzRmvjnoewOeCeDh0Jcf%2BVoJ3xZfcyeTutqqYS5YrnPTg%3D%3D--LN44ikYnA5UiD9Bg--IhKHphFE%2BrQ8%2FwyiRtdCJA%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/@tinaciousz/collections/10-useful-linkedin-tools' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'
#   {
#     "operationName":"ProfileLayoutQuery",
#     "variables":{"username":"tinaciousz"},
#     "query":"query ProfileLayoutQuery($username:String\u0021)
#     {
#         profile:user(username:$username)
#         {
#             id isTrashed productsCount submittedPostsCount
#             collectionsCount followersCount followingsCount
#             collectionsCount username
#             ...ProfileLayoutHeaderFragment __typename
#         }
#     }
#     fragment ProfileLayoutHeaderFragment on User{id headline headerUuid isFollowingViewer isMaker isViewer name twitterUsername username visitStreak{emoji duration __typename}  ...UserStackPreviewFragment __typename}



#     fragment UserStackPreviewFragment on User{id username stacksCount
#       stacks(first:20)
#       {
#         edges
#         {
#           node
#           {
#             id product{id slug ...ProductThumbnailFragment __typename}__typename}__typename}__typename}__typename}
#     fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}"}' \
#   --compressed  > "test.json"



# filter: all, discussions, reviews, comments, posts
# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6IjNiOWQ1ZTNiLTRlY2UtNGRmNy1iYmM3LWI4YTZmZmIwZDkzZSIsImNyZWF0ZWQiOjE2ODk4NTg5MjUxMzAsImluU2FtcGxlIjp0cnVlfQ==; _ga_WZ46833KH9=GS1.1.1689858924.26.1.1689859562.50.0.0; csrf_token=fdPOMeSWc48R_f8iNR33Q4MBb1VNhyUeAdunYRmq8AdBZjiRWUjlhJlEzeclCxtGClXBTinrIzYXIfWtD-GJ9Q; _producthunt_session_production=we6cLBiweZfsQV0UiGuVIe320Fn%2FPR8xnkTKlRYZAx5j1oEc9F0Ho9gOzCn7KmsztCPLk9rK111%2BOqmzY9XN4F%2B2q7k8H8SCtjrQTFUUqgS8Ky8WLtsTDdIfqwmDGUc4dIUHG89C9PAW5fxnOAwZRibh5dOr45cnKnOD30k6BsgQZ9kCuWSw55CTje%2FQPeVnUCyFhQnUVvDEiAkFHY7P2WKjDIrBLS5A%2B8FkLtL5UMRdENkTb5l67WENip9rG%2F9zjJOZFtmMo7EoQWqBKaBB12R2KVXYHjiIP%2B1XfcRgQf1856DVX0g1GcAZhPoe0U9hgujLXVckdLebt3izeg%3D%3D--sJWR2y%2FppFXOmX7V--uRX8mWnzf6Ua1pSjO3FACA%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/@shaanvp/upvotes' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'
#   {
#     "operationName":"ProfileActivityPage",
#     "variables":{"username":"shaanvp"},
#     "query":"query ProfileActivityPage($username:String\u0021)
#     {
#       profile:user(username:$username)
#       {
#         id name isViewer
#         activityEvents(first:10)
#         {
#           edges
#           {
#             node
#             {
#               id occurredAt groupedActivityCount
#               user{id ...ActivityUserFragment __typename}
#               subject{...ProfileActivityCommentFragment ...ProfileActivityReviewFragment ...ProfileActivityDiscussionThreadFragment ...ProfileActivityPostFragment __typename}__typename
#             }__typename
#           }
#           totalCount pageInfo{endCursor hasNextPage __typename}
#           __typename
#         }
#         ...MetaTags __typename
#       }
#     }
#     fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}
#     fragment ProfileActivityCommentFragment on Comment{id path bodyText user{id ...ActivityUserFragment __typename}subject{id ...on Post{id name slug tagline votesCount hasVoted ...PostThumbnail __typename}...on DiscussionThread{id title slug user{id ...UserImage __typename}__typename}...on AnthologiesStory{id title slug author{id ...UserImage __typename}__typename}__typename}__typename}
#     fragment ActivityUserFragment on User{id name ...UserImage __typename}
#     fragment UserImage on User{id name username avatarUrl __typename}
#     fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}
#     fragment PostStatusIcons on Post{id name productState __typename}
#     fragment ProfileActivityReviewFragment on Review{id ...ReviewActivityItemFragment __typename}
#     fragment ReviewActivityItemFragment on Review{id path overallExperience rating createdAt ...RatingReviewActionBarFragment user{id name ...UserImage __typename}product{id name path slug tagline ...ProductThumbnailFragment ...ReviewStarRatingCTAFragment __typename}__typename}
#     fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}
#     fragment ReviewStarRatingCTAFragment on Product{id slug name isMaker reviewsRating __typename}
#     fragment RatingReviewActionBarFragment on Review{id createdAt hasVoted votesCount ...ReviewDeleteButtonFragment ...RatingReviewShareButtonFragment ...RatingReviewEditButtonFragment ...RatingReviewReportButtonFragment ...RatingReviewReplyButtonFragment __typename}
#     fragment ReviewDeleteButtonFragment on Review{id canDestroy rating __typename}
#     fragment RatingReviewShareButtonFragment on Review{id url user{id name __typename}__typename}
#     fragment RatingReviewEditButtonFragment on Review{id canUpdate product{id name slug __typename}__typename}
#     fragment RatingReviewReportButtonFragment on Review{id __typename}
#     fragment RatingReviewReplyButtonFragment on Review{id product{id isMaker __typename}__typename}
#     fragment ProfileActivityDiscussionThreadFragment on DiscussionThread{id slug title descriptionText category{id name slug __typename}user{id ...ActivityUserFragment __typename}__typename}
#     fragment ProfileActivityPostFragment on Post{id name userId description slug tagline hasVoted votesCount ...PostThumbnail __typename}

#   "}' \
#   --compressed > "test.json"


# # activityEvents(first:$activityLimit after:$eventsCursor filter:$filter)


# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjSession_3508551=eyJpZCI6IjNiOWQ1ZTNiLTRlY2UtNGRmNy1iYmM3LWI4YTZmZmIwZDkzZSIsImNyZWF0ZWQiOjE2ODk4NTg5MjUxMzAsImluU2FtcGxlIjp0cnVlfQ==; _ga_WZ46833KH9=GS1.1.1689861561.27.1.1689862409.1.0.0; _hjIncludedInSessionSample_3508551=0; csrf_token=tpywJzOM6qpbc26P9fDBmbAb61Ddr-BZPzt2RuCkQYyKKUaHjlJ8odPKXErl5i2cOU9FS7nD5nEpwSSK9u84fg; _producthunt_session_production=rGUMxir0H9MsgLVx7jpnlMn%2FOmkYB4B8th20bXCLSc75VgQ0nR9wKs63KI2C23wgPZqdsjLegmOF87LJ7wcEh1%2BNi7R%2FA0Kco%2BvwXqq4t857W6LklbZWu78klqcnRyRHXnPCUE7rh6hXC8ciUgud6296sh8CAjCHCQgjvj3gHt7065uJQbEq%2BhH5P%2Fsrzhnd0l%2BlRl4l8SFoVeihe5Crx4bgho9TiBImmHHMB88f0JMA%2FKYOR7kOcCIi020BeQpz0%2FIIqqgsAKX7DpOtKDvUWmfM30nPQ9sM7ZviQ2uJJe6Ia52DnFYFt1RzZWV2l16REtpocbK2resTmg9ELA%3D%3D--JXrQYwHOPrFSwLIB--7q2Odv3zs7OugKzIF20SEg%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/@shaanvp' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'
#   {
#     "operationName":"ProfileFollowersQuery",
#     "variables":{"username":"shaanvp","cursor":null,"query":""},
#     "query":"query ProfileFollowersQuery($username:String\u0021$cursor:String)
#     {
#       profile:user(username:$username)
#       {
#         id followersCount followers(first:20 after:$cursor){edges{node{id ...UserItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}...MetaTags __typename}}fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}fragment UserItemFragment on User{id name headline username followersCount ...UserImage ...UserFollowButtonFragment __typename}fragment UserFollowButtonFragment on User{id followersCount isFollowed __typename}fragment UserImage on User{id name username avatarUrl __typename}"}' \
#   --compressed > "test.json"


# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjSession_3508551=eyJpZCI6IjNiOWQ1ZTNiLTRlY2UtNGRmNy1iYmM3LWI4YTZmZmIwZDkzZSIsImNyZWF0ZWQiOjE2ODk4NTg5MjUxMzAsImluU2FtcGxlIjp0cnVlfQ==; _hjIncludedInSessionSample_3508551=0; csrf_token=KFk_yyRZvEiKGBlGyxsUGwqCtakVg4XzdC_yxcYf1i0U7MlrmYcqQwKhK4PbDfgeg9YbsnHvg9ti1aAJ0FSv3w; _producthunt_session_production=Dj9WbzYc%2B1ip7ATfFhdREBjNGs9QoD%2F7m4qC6Ig%2FrWV7ZGw%2Fix8uU5T4u5RbfHQ%2BB6RO00tgwDHTR8843E7Oo8jGhhVmxGJm8FY%2FN566ahLgTcPG9oRezZhNi9b%2BsXtssXIE8vL3VN5OalH8MjM7%2BvKB2gefSvAf88mbD7WkZe%2BONFideE%2FLpllcvwxHYII1U1ZOpelTC%2B7zNUMKG6e5Lr0P98OfSpyLSapbsS49RCth9AdCIIOV8Jyo5y0SsCxCEWtdS2gq8blNQofE60ZMZKUJJOkry8a0HOfDYRvrnhT4AF4fle8BG3DU7kSm9pIIJHfK6j%2Bncvlz7l5oWg%3D%3D--1snX7rbHVessLbTT--mOnfxj3gTTLb6GQM5B9Ojg%3D%3D; _ga_WZ46833KH9=GS1.1.1689861561.27.1.1689862414.60.0.0' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/@shaanvp/followers' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'{"operationName":"ProfileFollowingQuery","variables":{"username":"shaanvp","cursor":null,"query":""},"query":"query ProfileFollowingQuery($username:String\u0021$cursor:String){profile:user(username:$username){id isTrashed followingsCount following(first:20 after:$cursor){edges{node{id ...UserItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}...MetaTags __typename}}fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}fragment UserItemFragment on User{id name headline username followersCount ...UserImage ...UserFollowButtonFragment __typename}fragment UserFollowButtonFragment on User{id followersCount isFollowed __typename}fragment UserImage on User{id name username avatarUrl __typename}"}' \
#   --compressed


# curl 'https://www.producthunt.com/frontend/graphql' \
#   -H 'authority: www.producthunt.com' \
#   -H 'accept: */*' \
#   -H 'accept-language: en,vi;q=0.9' \
#   -H 'content-type: application/json' \
#   -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _ga_WZ46833KH9=GS1.1.1689868314.28.0.1689868314.60.0.0; csrf_token=eHJ0tkepVy5gcM9TTCi-ze__z3jbDBNiDM4JkUIL6v1Ex4IW-nfBJejJ_ZZcPlLIZqthY79gFUoaNFtdVECTDw; _producthunt_session_production=k6z64f%2FinMITbtlyw5iZJtpV8wepoCklrgxU3dx5cQoGxbn1xUiVvfWwfZGMyBizBA%2FPANRkrxAS7sSHp098C16mvmrHs4ZYy6febKF9jxAm9VtpYcJ4MOVrLLkRhrJXFk5LiInWmo%2FqsZ5WyoRYN7rFfZpVM9t4bXBqSv1ltorWqpo0jwfAskXoY38%2FJv06sbh%2BaI131AttcoBbe5vsv6NyFRp3RrpfiIh5lfU5AAjUxF9MLYbnrLyZLsp8LSLnHmTyH%2FTKn8TwA5MrcD85%2FY%2B8hD1Bs5O0StzdU0o%2Bs8V3IR2oVK%2BZ6SfR%2FDQALnIl5kN4hc1JFJUduH3YMw%3D%3D--u9ahz5AB8FmCICX0--3TwkdBXE4oWAcCb3BEqdWg%3D%3D' \
#   -H 'dnt: 1' \
#   -H 'origin: https://www.producthunt.com' \
#   -H 'referer: https://www.producthunt.com/categories/calendars' \
#   -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
#   -H 'sec-ch-ua-mobile: ?0' \
#   -H 'sec-ch-ua-platform: "macOS"' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-site: same-origin' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
#   -H 'x-requested-with: XMLHttpRequest' \
#   --data-raw $'
#   {
#     "operationName":"ProductCategoryPage",
#     "variables":{"slug":"calendars","cursor":"MjA","order":"best_rated"},
#     "query":"query ProductCategoryPage($slug:String\u0021$cursor:String$order:CategoryProductsOrder\u0021)
#     {
#       productCategory(slug:$slug)
#       {
#         id description displayName name path parent{id name path __typename}
#         meta{title description __typename}
#         topProducts:products(first:8 order:best_rated){edges{node{id name ...ProductThumbnailFragment __typename}__typename}__typename}
#         targetedAd(kind:\\"feed\\"){id ...AdFragment __typename}
#         ...ProductCategoryPageProductListFragment
#         ...CategorySidebarCategoryListFragment
#         ...CategorySidebarNewestProductsFragment __typename
#       }
#       sidebarAd:ad(kind:\\"sidebar\\"){id ...AdFragment __typename}
#     }
#     fragment ProductCategoryPageProductListFragment on ProductCategory
#     {
#       id products(first:10 after:$cursor order:$order)
#       {
#         edges
#         {
#           node
#           {
#             id description reviewsCount reviewsRating slug
#             stackers(first:3)
#             {
#               edges
#               {
#                 node{id ...UserCircleListFragment __typename}__typename
#               }
#               totalCount __typename
#             }
#             websiteUrl
#             ...ProductThumbnailFragment
#             ...ProductStackButtonFragment __typename
#           }__typename
#         }
#         pageInfo{endCursor hasNextPage __typename}__typename
#       }__typename
#     }
#     fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}
#     fragment ProductStackButtonFragment on Product{id name isStacked stacksCount __typename}
#     fragment UserCircleListFragment on User{id ...UserImage __typename}
#     fragment UserImage on User{id name username avatarUrl __typename}
#     fragment CategorySidebarCategoryListFragment on ProductCategory{id name displayName parent{id ...CategorySidebarCategoryListItemFragment subCategories(first:20){edges{node{id ...CategorySidebarCategoryListItemFragment __typename}__typename}__typename}__typename}subCategories(first:20){edges{node{id ...CategorySidebarCategoryListItemFragment __typename}__typename}__typename}__typename}
#     fragment CategorySidebarCategoryListItemFragment on ProductCategory{id name displayName path __typename}
#     fragment CategorySidebarNewestProductsFragment on ProductCategory{id name displayName newestProducts:products(first:3 order:most_recent){edges{node{id name tagline reviewsRating slug ...ProductThumbnailFragment __typename}__typename}__typename}__typename}
#     fragment AdFragment on Ad{id subject post{id slug name updatedAt commentsCount topics(first:1){edges{node{id name __typename}__typename}__typename}...PostVoteButtonFragment __typename}ctaText name tagline thumbnailUuid url __typename}
#     fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}

#   "}' \
#   --compressed  > "test.json"
