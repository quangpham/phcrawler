# https://www.producthunt.com/all
# ./GetRecentProducts.sh cursor
# ./GetRecentProducts.sh 1-181
# kind: FEATURED, ALL, POPULAR, NEWEST

# filters: {}
# filters: {bootstrapped: true}, {soloMaker: true}

mkdir -p tmp/recent-products/

curl 'https://www.producthunt.com/frontend/graphql' \
  -H 'authority: www.producthunt.com' \
  -H 'accept: */*' \
  -H 'accept-language: en,vi;q=0.9' \
  -H 'content-type: application/json' \
  -H 'cookie: _ga=GA1.1.521910990.1689472726; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689472725565%22}}}; ajs_anonymous_id=8169299d-ab73-4fb4-97a1-11eff39d595c; visitor_id=a145b6c6-84d8-49ba-b565-5922df9bc8e8; track_code=81ad6b58d9; agreed_cookie_policy=2023-07-15+18%3A58%3A53+-0700; _hjSessionUser_3508551=eyJpZCI6IjM5ZGEyNjY2LTY0YjItNTBjYS05MzUzLTNjNzA2N2VlMTcxNiIsImNyZWF0ZWQiOjE2ODk0NzI3MjYyNjYsImV4aXN0aW5nIjp0cnVlfQ==; g_state={"i_p":1690333897969,"i_l":3}; first_visit=1689900073; first_referer=; analytics_session_id=1690176736393; _hjIncludedInSessionSample_3508551=0; _hjSession_3508551=eyJpZCI6IjE0MTRmNzNhLWFmMGItNDk0OS05MjQ0LTFhMDk1ZWI2NjkyOSIsImNyZWF0ZWQiOjE2OTAxNzY3MzY3NjUsImluU2FtcGxlIjpmYWxzZX0=; _ga_WZ46833KH9=GS1.1.1690176736.39.1.1690178622.16.0.0; csrf_token=SfAa8T2rpEI5y6-Kw7P1z_AqJsjvT5xXNXOBFzNU0y11RexRgHUySbFynU_TpRnKeX6I04sjmn8jidPbJR-q3w; _producthunt_session_production=maGrhnmsKJDf0CK1J9iiCdCAGFyjaJiAHAf%2FeTVVfAhCTdhtFCZ%2FPhWO22OC0Rm8IuC17UM94dIVqYzogPDju9%2FNgoBbXCwTRXBx8rQSXa9Nu8CX9nyllLA8f%2Bb%2Fx%2BM%2B1aWP24kJQZlMmLXemt%2FoQIYghD2JQToGtlsK2rHZ2rQ4qcjUq%2FxKW1blPhjanPS9yY%2BEpe1C65ajrAPVOmZIDMJ8H8IkWurAhUf2KGC5aGMFh0bwNtlZNnwwnnk%2B%2F2RGB6972HfrKeU79wRwxN0w8PPDNhwbhPxxenheWu9lpXoP8OE%2BSmeza%2Bu3nN0MWMUYZZi7utGl0VvSqXEyzg%3D%3D--51epz9pnhWBCoR2C--dR%2BOKEzmjHZ1SV13zTdNjQ%3D%3D; analytics_session_id.last_access=1690178695834' \
  -H 'dnt: 1' \
  -H 'origin: https://www.producthunt.com' \
  -H 'referer: https://www.producthunt.com/all' \
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
    "operationName":"HomePage",
    "variables":{"cursor":"'$1'","kind":"ALL","filters":{}},
    "query":"query HomePage($cursor:String$kind:HomefeedKindEnum\u0021$filters:HomefeedFiltersInput\u0021)
    {
        homefeed(after:$cursor kind:$kind filters:$filters)
        {
            kind
            edges
            {
                node
                {
                    id title subtitle hideAfter date randomization
                    items
                    {
                        ...on Post
                            {
                                id hideVotesCount ...PostItemFragment featuredComment{id body:bodyText user{id ...UserImage __typename}__typename}__typename
                            }
                        ...on DiscussionThread{id ...DiscussionHomepageItemFragment __typename}
                        ...on AnthologiesStory{id ...StoryHomepageItemFragment __typename}
                        ...on Ad{id ...AdFragment __typename}
                        ...on Collection{id ...CollectionHomepageItemFragment __typename}__typename
                    }
                    ...ComingSoonCardHomepageFragment __typename
                }__typename
            }
            pageInfo{hasNextPage endCursor __typename}__typename
        }
        mainBanner:banner(position:MAINFEED){id description url desktopImageUuid wideImageUuid tabletImageUuid mobileImageUuid __typename}
        phHomepageOgImageUrl viewer{id showHomepageOnboarding __typename}
    }
    fragment AdFragment on Ad{id subject post{id slug name updatedAt commentsCount topics(first:1){edges{node{id name __typename}__typename}__typename}...PostVoteButtonFragment __typename}ctaText name tagline thumbnailUuid url __typename}
    fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id slug isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}
    fragment PostItemFragment on Post
    {
        id commentsCount name shortenedUrl slug tagline updatedAt pricingType
        topics(first:1){edges{node{id name slug __typename}__typename}__typename}
        redirectToProduct{id slug __typename}
        ...PostThumbnail ...PostVoteButtonFragment __typename
    }
    fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}
    fragment PostStatusIcons on Post{id name productState __typename}
    fragment UserImage on User{id name username avatarUrl __typename}
    fragment DiscussionHomepageItemFragment on DiscussionThread{id title descriptionText slug commentsCount user{id firstName username avatarUrl name headline isMaker isViewer badgesCount badgesUniqueCount karmaBadge{kind score __typename}__typename}discussionCategory:category{id name slug __typename}...DiscussionThreadItemVote __typename}
    fragment DiscussionThreadItemVote on DiscussionThread{id hasVoted votesCount __typename}
    fragment StoryHomepageItemFragment on AnthologiesStory{id slug title description minsToRead commentsCount ...StoryVoteButtonFragment storyCategory:category{name slug __typename}author{id username firstName avatarUrl name headline isMaker isViewer badgesCount badgesUniqueCount karmaBadge{kind score __typename}__typename}__typename}
    fragment StoryVoteButtonFragment on AnthologiesStory{id hasVoted votesCount __typename}
    fragment CollectionHomepageItemFragment on Collection{id slug name collectionTitle:title description user{id name username __typename}...CollectionsThumbnailsFragment __typename}
    fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}
    fragment CollectionsThumbnailsFragment on Collection{products(first:1){edges{node{id ...ProductThumbnailFragment __typename}__typename}__typename}__typename}
    fragment ComingSoonCardHomepageFragment on HomefeedPage{comingSoon{id ...UpcomingEventItemFragment __typename}__typename}
    fragment UpcomingEventItemFragment on UpcomingEvent{id title truncatedDescription isSubscribed post{id createdAt __typename}product{id slug postsCount followersCount followers(first:3 order:popularity excludeViewer:true){edges{node{id ...UserCircleListFragment __typename}__typename}__typename}...ProductItemFragment __typename}...FacebookShareButtonV6Fragment __typename}
    fragment ProductItemFragment on Product{id slug name tagline followersCount reviewsCount topics(first:2){edges{node{id slug name __typename}__typename}__typename}...ProductFollowButtonFragment ...ProductThumbnailFragment ...ProductMuteButtonFragment ...FacebookShareButtonV6Fragment ...ReviewStarRatingCTAFragment __typename}
    fragment ProductFollowButtonFragment on Product{id followersCount isSubscribed __typename}
    fragment ProductMuteButtonFragment on Product{id isMuted __typename}
    fragment FacebookShareButtonV6Fragment on Shareable{id url __typename}
    fragment ReviewStarRatingCTAFragment on Product{id slug name isMaker reviewsRating __typename}
    fragment UserCircleListFragment on User{id ...UserImage __typename}
    "
}' \
  --compressed > "tmp/recent-products/r.$1.json"
