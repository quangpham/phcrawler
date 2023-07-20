# Profile About
# https://www.producthunt.com/@jesv
# co the lay linkedin => Nam trong links

# ./GetUserProfile.sh username
# ./GetUserProfile.sh jesv
# collections duoc max 100
# submittedPosts duoc max 20

mkdir -p tmp/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1689729091; first_referer=https://www.google.com/; g_state={"i_p":1690333897969,"i_l":3}; _hjIncludedInSessionSample_3508551=0; _hjSession_3508551=eyJpZCI6ImU5YmNhMjkzLWI5ZTctNDY2NC1iNmNiLTc0MmE3Yjk0NzdlOCIsImNyZWF0ZWQiOjE2ODk3NTQ3NTQxNjAsImluU2FtcGxlIjpmYWxzZX0=; _ga_WZ46833KH9=GS1.1.1689754754.18.1.1689755019.21.0.0; csrf_token=su6BbS8ndrrD-K4XlMR--uEhydjUaUKO4mwKoSwrP0GOW3fNkvngsUtBnNKE0pL_aHVnw7AFRKb0llhtOmBGsw; _producthunt_session_production=r6M8aUFswoOLauKDN3L8CXd6dGe%2FeufqxHzRc8qGwHjsGpIvLkFCASgrfsccirURo0UawaiHGL%2Bi%2Fy7oOMxCHGCPHqHV%2FpEJ80AI1VhDRCduAKACSRNnUrk30CM4XuzL1kSi%2BIamwgZc5tCUfi6AhHkUi2tPiAx6w5jHCORR5sS00RSSPO4bs220e41L%2FfXV3UC32mKUDkoz79bfz6m91tFO7e82xbXetihL0uACiaRLrkqivvYVmta16fCXr0zNvHjta%2BHhfqh0jGI8Skgq4MzFiT6Rae65Gnir%2BKgRTsU9Px9u7ULDZEBzgxeGghvt7d22XG5NK63BOBGp8A%3D%3D--ma7WFX0zeDKxtIaW--T%2FiUjFwjbgZbOjQFAzCrxQ%3D%3D' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/@jesv/activity' \
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
    "operationName":"ProfileAboutPage",
    "variables":{"username":"'$1'"},
    "query":"query ProfileAboutPage($username:String\u0021)
    {
      profile:user(username:$username)
      {
        id name about username headline
        twitterUsername websiteUrl
        isMaker isTrashed
        followersCount followingsCount badgesCount
        productsCount votesCount collectionsCount submittedPostsCount stacksCount
        createdAt
        submittedPosts { edges { node{id} } }
        collections
        {
          edges
          {
            node
            {
              id name title description path productsCount createdAt
              products { edges { node {id} } }
            }
          }
        }
        links { id name url kind }
        stacks { edges {node { id product { id slug } } } }
        badgeGroups{ awardKind badgesCount }
        followedTopics { edges {node { id } } }
        visitStreak { duration }
      }
    }

  "}' \
  --compressed > "tmp/_r.profile.$1.ongoing"

mv "tmp/_r.profile.$1.ongoing" "tmp/_r.profile.$1.json"




# stacks(first:20) { { node {id product { id } } } }
    #     votedPosts(first:8){
    #       edges{node{id ...PostItemFragment __typename}__typename}
    #       pageInfo{endCursor hasNextPage __typename}__typename
    #     }
    #     newProducts(first:5 after:$newProductsCursor){
    #       edges{node{id ...MakerHistoryItemFragment __typename}__typename}
    #       pageInfo{startCursor endCursor hasNextPage __typename}__typename
    #     }
    #     ...JobTitleFragment
    #     __typename


    # fragment PostItemFragment on Post{id commentsCount name shortenedUrl slug tagline updatedAt pricingType topics(first:1){edges{node{id name slug __typename}__typename}__typename}redirectToProduct{id slug __typename}...PostThumbnail ...PostVoteButtonFragment __typename}
    # fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}
    # fragment PostStatusIcons on Post{id name productState __typename}
    # fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}
    # fragment ProfileAboutUserLinkFragment on UserLink{id name encodedUrl kind __typename}
    # fragment MakerHistoryItemFragment on Product{id name createdAt tagline createdAt slug ...ProductThumbnailFragment makerPosts(madeBy:$username){edges{node{id name tagline thumbnailImageUuid createdAt slug __typename}__typename}__typename}__typename}
    # fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}
    # fragment JobTitleFragment on User{id work{id jobTitle companyName product{id name slug __typename}__typename}__typename}
