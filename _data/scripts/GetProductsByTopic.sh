# Lay toan products theo topic

# ./GetProductsByTopic.sh so-thu-tu $topic-name $order $cursor
# ./GetProductsByTopic.sh 1 task-management most_recent NjA(or blank)
# ./GetProductsByTopic.sh 1 task-management best_rated NjA(or blank)

# order: most_recent, oldest, posts_count, most_followed, best_rated, tech_stacks_count, used_by_products_count
# postsorder: DATE, VOTES
# reviewssorder: BEST, LATEST, FAVORABLE, CRITICAL

mkdir -p tmp/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: first_visit=1689472725; first_referer=https://www.google.com/; _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; g_state={"i_p":1689479930148,"i_l":1}; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6ImFlMzA3ODUwLWMwOTgtNDAxMC1hYmY1LWViNTBhZjc4YTg0NCIsImNyZWF0ZWQiOjE2ODk0NzcwNTI2MDMsImluU2FtcGxlIjp0cnVlfQ==; csrf_token=Y4RxwXsDg4XKu2GnynXKW-4M1nxqhvPcVhKREVU7tQJfMYdhxt0VjkICU2LaYyZeZ1h4Zw7q9fRA6MPdQ3DM8A; _producthunt_session_production=sTuESFyN%2Bh6IMPzT7vLLxpWb7Jj%2Ft41cegHxbuy4MAWKu60okT%2BeLvS817FPFtdCm7yGCFhevaF0DF4H54%2Bx23f3Xf47Xz0AJHAnYBy48mI6CVix6F5QQdh%2BnppRfnLe%2B4QpBAnId8XAhfEb7si8kmOHSg8034%2FE%2Fi8jRgP5Slg8zq%2B3v62Jbo8DSZbHCIF%2B%2F1WklTsLq8uc3Zyre8HiyfEVdqctvrpNtkyqRHp0FEQpOP1NgBD31jEyLmPZJDhgVjip5UWD%2BnqqFUXqj%2Fg6Js7mDeOHoY4gE%2FnxS8gLEi%2FlTQ7g5Pfa4BioG0WXWY9clFVBv%2BjSKpnnXO7TCg%3D%3D--YNsbDLhKM7odeyCe--X03qDhAckJH3MYmcpbLoew%3D%3D; _ga_WZ46833KH9=GS1.1.1689477052.2.1.1689477076.36.0.0' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/topics/productivity' \
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
        "variables":{"slug":"'$2'","order":"'$3'","cursor":"'$4'","includeLayout":false,"postsorder":"DATE","reviewssorder":"LATEST"},
        "query":"query TopicPage($slug:String\u0021$cursor:String$order:ProductsOrder\u0021$postsorder:ProductsPostsOrder\u0021$reviewssorder:ReviewsOrder\u0021)
          {
            topic(slug:$slug)
              {
                id
                products(first:20 after:$cursor order:$order excludeHidden:false) {
                  edges {
                    node {
                      id slug name tagline logoUuid
                      followersCount reviewsRating
                      createdAt

                      reviews(first:20 order:$reviewssorder){
                        edges{
                          node {
                            id createdAt
                            user {
                                id name username twitterUsername
                                websiteUrl followersCount followingsCount
                                badgesCount karmaBadge{score} isTrashed createdAt
                            }
                          }
                        }
                        totalCount
                      }

                      topics(first:100) { edges{node{id}} }
                      posts(first:100 order:$postsorder) { edges{node{id slug createdAt}} totalCount }
                    }
                  }
                  totalCount pageInfo {endCursor hasNextPage}
                }

              }
          }

          "
      }' \
  --compressed> "tmp/_r.product-by-topic.$1.$2.$3.$4.ongoing"

mv "tmp/_r.product-by-topic.$1.$2.$3.$4.ongoing" "tmp/_r.product-by-topic.$1.$2.$3.$4.json"


# RAW 16/07/2023
  # curl 'https://www.producthunt.com/frontend/graphql' \
  # -H 'authority: www.producthunt.com' \
  # -H 'accept: */*' \
  # -H 'accept-language: en,vi;q=0.9' \
  # -H 'content-type: application/json' \
  # -H 'cookie: first_visit=1689472725; first_referer=https://www.google.com/; _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; g_state={"i_p":1689479930148,"i_l":1}; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6ImFlMzA3ODUwLWMwOTgtNDAxMC1hYmY1LWViNTBhZjc4YTg0NCIsImNyZWF0ZWQiOjE2ODk0NzcwNTI2MDMsImluU2FtcGxlIjp0cnVlfQ==; csrf_token=Y4RxwXsDg4XKu2GnynXKW-4M1nxqhvPcVhKREVU7tQJfMYdhxt0VjkICU2LaYyZeZ1h4Zw7q9fRA6MPdQ3DM8A; _producthunt_session_production=sTuESFyN%2Bh6IMPzT7vLLxpWb7Jj%2Ft41cegHxbuy4MAWKu60okT%2BeLvS817FPFtdCm7yGCFhevaF0DF4H54%2Bx23f3Xf47Xz0AJHAnYBy48mI6CVix6F5QQdh%2BnppRfnLe%2B4QpBAnId8XAhfEb7si8kmOHSg8034%2FE%2Fi8jRgP5Slg8zq%2B3v62Jbo8DSZbHCIF%2B%2F1WklTsLq8uc3Zyre8HiyfEVdqctvrpNtkyqRHp0FEQpOP1NgBD31jEyLmPZJDhgVjip5UWD%2BnqqFUXqj%2Fg6Js7mDeOHoY4gE%2FnxS8gLEi%2FlTQ7g5Pfa4BioG0WXWY9clFVBv%2BjSKpnnXO7TCg%3D%3D--YNsbDLhKM7odeyCe--X03qDhAckJH3MYmcpbLoew%3D%3D; _ga_WZ46833KH9=GS1.1.1689477052.2.1.1689477076.36.0.0' \
  # -H 'dnt: 1' \
  # -H 'origin: https://www.producthunt.com' \
  # -H 'referer: https://www.producthunt.com/topics/productivity' \
  # -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
  # -H 'sec-ch-ua-mobile: ?0' \
  # -H 'sec-ch-ua-platform: "macOS"' \
  # -H 'sec-fetch-dest: empty' \
  # -H 'sec-fetch-mode: cors' \
  # -H 'sec-fetch-site: same-origin' \
  # -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
  # -H 'x-requested-with: XMLHttpRequest' \
  # --data-raw $'{"operationName":"TopicPage","variables":{"slug":"productivity","cursor":"MTA","topPostsVariant":"THIS_WEEK","order":"best_rated","includeLayout":false},"query":"query TopicPage($slug:String\u0021$cursor:String$order:ProductsOrder\u0021){topic(slug:$slug){id slug parent{id name slug __typename}...MetaTags ...TopicPageHeaderFragment ...TopicPageProductListFragment ...TopicPageProductQuestionsFragment ...TopReviewedProductsCardFragment targetedAd(kind:\\"feed\\"){...AdFragment __typename}subscribers(first:50){edges{node{id ...UserGridCardFragment __typename}__typename}__typename}recentStacks(first:3){edges{node{id ...TopicPageRecentStackFragment __typename}__typename}__typename}__typename}viewer{id ...TopicsNewsletterCardFragment __typename}}fragment MetaTags on SEOInterface{id meta{canonicalUrl creator description image mobileAppUrl oembedUrl robots title type author authorUrl __typename}__typename}fragment AdFragment on Ad{id subject post{id slug name updatedAt commentsCount topics(first:1){edges{node{id name __typename}__typename}__typename}...PostVoteButtonFragment __typename}ctaText name tagline thumbnailUuid url __typename}fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}fragment TopicPageHeaderFragment on Topic{id name description parent{id name slug __typename}...TopicFollowButtonFragment __typename}fragment TopicFollowButtonFragment on Topic{id slug name isFollowed followersCount ...TopicImage __typename}fragment TopicImage on Topic{name imageUuid __typename}fragment TopicPageProductListFragment on Topic{id name slug products(first:10 after:$cursor order:$order excludeHidden:true){edges{node{id ...ReviewCTAPromptFragment ...ProductItemFragment __typename}__typename}pageInfo{endCursor hasNextPage __typename}__typename}__typename}fragment ProductItemFragment on Product{id slug name tagline followersCount reviewsCount topics(first:2){edges{node{id slug name __typename}__typename}__typename}...ProductFollowButtonFragment ...ProductThumbnailFragment ...ProductMuteButtonFragment ...FacebookShareButtonV6Fragment ...ReviewStarRatingCTAFragment __typename}fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}fragment ProductFollowButtonFragment on Product{id followersCount isSubscribed __typename}fragment ProductMuteButtonFragment on Product{id isMuted __typename}fragment FacebookShareButtonV6Fragment on Shareable{id url __typename}fragment ReviewStarRatingCTAFragment on Product{id slug name isMaker reviewsRating __typename}fragment ReviewCTAPromptFragment on Product{id isMaker viewerReview{id __typename}...ReviewCTASharePromptFragment __typename}fragment ReviewCTASharePromptFragment on Product{id name tagline slug ...ProductThumbnailFragment ...FacebookShareButtonFragment __typename}fragment FacebookShareButtonFragment on Shareable{id url __typename}fragment TopReviewedProductsCardFragment on Topic{id topReviewedProducts(first:4){edges{node{id name tagline reviewsRating slug path ...ProductThumbnailFragment ...ReviewStarRatingCTAFragment reviewSnippet{id overallExperience user{id ...UserImage __typename}__typename}__typename}__typename}__typename}__typename}fragment UserImage on User{id name username avatarUrl __typename}fragment UserGridCardFragment on User{id ...UserImage __typename}fragment TopicsNewsletterCardFragment on Viewer{id settings{sendAiEmail sendProductivityEmail __typename}__typename}fragment TopicPageRecentStackFragment on ProductStack{id user{id name username isTrashed ...UserImage __typename}product{id name tagline slug ...ProductThumbnailFragment __typename}__typename}fragment TopicPageProductQuestionsFragment on Topic{productQuestions(first:1 filter:NOT_ANSWERED excludeSkipped:true){edges{node{id path title ...ProductQuestionAnswerFlowFragment ...ProductQuestionAnswerPromptFragment ...ProductQuestionShareButtonFragment ...ProductQuestionReviewFlowFragment __typename}__typename}__typename}__typename}fragment ProductQuestionAnswerFlowFragment on ProductQuestion{id slug path viewerAnswer{id product{id isMaker viewerReview{id __typename}...ReviewFormProductFragment __typename}__typename}__typename}fragment ReviewFormProductFragment on Product{id name slug isMaker isSubscribed isStacked reviewsRating reviewsCount reviewsWithBodyCount reviewsWithRatingCount ratingSpecificCount{rating count __typename}viewerReview{id __typename}__typename}fragment ProductQuestionReviewFlowFragment on ProductQuestion{id placeholder viewerAnswer{id product{id name viewerReview{id __typename}__typename}__typename}__typename}fragment ProductQuestionAnswerPromptFragment on ProductQuestion{id path canViewAnswers answerAuthors(first:3){edges{node{id ...UserCircleListFragment __typename}__typename}totalCount __typename}__typename}fragment UserCircleListFragment on User{id ...UserImage __typename}fragment ProductQuestionShareButtonFragment on ProductQuestion{id ...FacebookShareButtonV6Fragment __typename}"}' \
  # --compressed


# fragment ReviewListFragment on Reviewable{id __typename}
