#./KevinPhamFollowAUser.sh user-id

username=$( tail -n 1  user_ids.txt | xargs)
username="${username//[$'\t\n\r']}"
echo $username

# sed -i '' -e '$ d' foo.txt # MAC OS
sed -i '$ d' user_ids.txt # LINUX


if [ -z "$username" ]
then
    echo "\$username is empty"
else
    curl 'https://www.producthunt.com/frontend/graphql' \
    -H 'authority: www.producthunt.com' \
    -H 'accept: */*' \
    -H 'accept-language: en-US,en;q=0.9' \
    -H 'content-type: application/json' \
    -H 'cookie: _ga=GA1.1.1140192422.1689681113; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689681113109%22}}}; ajs_anonymous_id=d6382c48-4da2-450b-8b03-a871432ac919; visitor_id=0244ede5-0944-44e1-8eb8-344a734ed311; track_code=012e63c16e; g_state={"i_l":0}; ajs_user_id=5849596; _hjSessionUser_3508551=eyJpZCI6ImEzZWI2NDU0LTMyM2MtNWI2Mi05OGRhLTc4YzQ4YzU0YTBkNiIsImNyZWF0ZWQiOjE2ODk2ODExMTMyODQsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1690726069; first_referer=; analytics_session_id=1690726069755; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6IjY5MmNhNDMwLTYzYjYtNGQ5Ni1iNTUyLTQ1YTAzYmU3OGM4MiIsImNyZWF0ZWQiOjE2OTA3MjYwNjk4ODgsImluU2FtcGxlIjp0cnVlfQ==; _hjAbsoluteSessionInProgress=1; _hjHasCachedUserAttributes=true; _ga_WZ46833KH9=GS1.1.1690726069.4.1.1690727323.20.0.0; analytics_session_id.last_access=1690727323096; csrf_token=KTXqyJ1GiFCfcEkJAg_hMwROfi8qJlPXi5Se-2pgTrrkvgDjKmyNXexB5Y9_1aKzUPTCOjU6LQp5WhyaG7Zpig; _producthunt_session_production=wZoo%2B9yusyyBE5ktPdnf6hMNatqwzlivfNUiZ6UqjCV2XZgZBtGL3ejKVNBWo09c48O1hju9K3VZnOlMX8uRq9%2B2BYxuOY9K4LN9SM0bUANY%2B87tR%2BGuG8yqwj0RxaoEGM6ZjOer7PUZGEnaURG7zOLi%2BwIiaPb6Yj1es9D5GIduhbB0WzfYRY8XbkToMTc4AmxbGLOa1wHdPWfBcabg9uQLR9zQ8JiHVIWQlbBABppjsQeqG0%2BfxFSpcCNWGzV7ejsUA1Ny2hmA5w41t0G3K%2Fn52QRt54crpFw8WQRt%2Bla9SsoOFJhyRRgaCqe9ntfG9AEPlobhv0q%2FjkuEHqURVK4BXwhJaWiyxximSGO5N4ERsHEg0Q%3D%3D--PgUEISiQXKm3FyYl--tTWtnt1QZsDLWCSVZ5%2FP6A%3D%3D' \
    -H 'origin: https://www.producthunt.com' \
    -H 'referer: https://www.producthunt.com/@saumya_dubey/followers' \
    -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: "macOS"' \
    -H 'sec-fetch-dest: empty' \
    -H 'sec-fetch-mode: cors' \
    -H 'sec-fetch-site: same-origin' \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
    -H 'x-requested-with: XMLHttpRequest' \
    --data-raw $'{"operationName":"UserFollowCreate","variables":{"input":{"userId":"'$username'","sourceComponent":"user_profile"}},"query":"mutation UserFollowCreate($input:UserFollowCreateInput\u0021){response:userFollowCreate(input:$input){node{id ...UserFollowButtonFragment __typename}__typename}}fragment UserFollowButtonFragment on User{id followersCount isFollowed __typename}"}' \
    --compressed
fi

echo \


