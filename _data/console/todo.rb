# Nhung thang post nao ko co product_id -> them cai nay
redirectToProduct {id }

# Nhung thang User muon lay them thong tin cong ty

work {
  id jobTitle companyName
  product {id name slug __typename}
  __typename
}

links {
  id name url encodedUrl kind
  __typename
}

followedTopics {
  edges
  {
    node
    {
      id name slug __typename
    }
    __typename
  }
  __typename
}

badgeGroups{awardKind badgesCount award{id name description imageUuid active __typename}__typename}




"operationName":"ProfileAboutPage",
"variables":{"username":"jesv","newProductsCursor":null},
"query":"query ProfileAboutPage($username:String\u0021$newProductsCursor:String)
{
  profile:user(username:$username)
  {
    id name username about badgesCount badgesUniqueCount productsCount votesCount createdAt
    links{...ProfileAboutUserLinkFragment __typename}
    followedTopics{edges{node{id name slug __typename}__typename}__typename}
    badgeGroups{awardKind badgesCount award{id name description imageUuid active __typename}__typename}
    votedPosts(first:8){
      edges{node{id ...PostItemFragment __typename}__typename}
      pageInfo{endCursor hasNextPage __typename}__typename
    }
    newProducts(first:5 after:$newProductsCursor){
      edges{node{id ...MakerHistoryItemFragment __typename}__typename}
      pageInfo{startCursor endCursor hasNextPage __typename}__typename
    }
    ...JobTitleFragment
    __typename
  }
}


fragment PostItemFragment on Post{id commentsCount name shortenedUrl slug tagline updatedAt pricingType topics(first:1){edges{node{id name slug __typename}__typename}__typename}redirectToProduct{id slug __typename}...PostThumbnail ...PostVoteButtonFragment __typename}
fragment PostThumbnail on Post{id name thumbnailImageUuid ...PostStatusIcons __typename}
fragment PostStatusIcons on Post{id name productState __typename}
fragment PostVoteButtonFragment on Post{id featuredAt updatedAt createdAt product{id isSubscribed __typename}disabledWhenScheduled hasVoted ...on Votable{id votesCount __typename}__typename}
fragment ProfileAboutUserLinkFragment on UserLink{id name encodedUrl kind __typename}
fragment MakerHistoryItemFragment on Product{id name createdAt tagline createdAt slug ...ProductThumbnailFragment makerPosts(madeBy:$username){edges{node{id name tagline thumbnailImageUuid createdAt slug __typename}__typename}__typename}__typename}
fragment ProductThumbnailFragment on Product{id name logoUuid isNoLongerOnline __typename}
fragment JobTitleFragment on User{id work{id jobTitle companyName product{id name slug __typename}__typename}__typename}
