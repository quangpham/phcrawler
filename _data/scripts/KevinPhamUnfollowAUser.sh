#./KevinPhamFollowAUser.sh user-id

mkdir -p tmp/pxq85-unfollowed/

curl 'https://www.producthunt.com/frontend/graphql' \
-H 'authority: www.producthunt.com' \
-H 'accept: */*' \
-H 'accept-language: en-US,en;q=0.9' \
-H 'content-type: application/json' \
-H 'cookie: _ga=GA1.1.1140192422.1689681113; _delighted_web={%2271AaKmxD4TpPsjYW%22:{%22_delighted_fst%22:{%22t%22:%221689681113109%22}}}; ajs_anonymous_id=d6382c48-4da2-450b-8b03-a871432ac919; visitor_id=0244ede5-0944-44e1-8eb8-344a734ed311; track_code=012e63c16e; g_state={"i_l":0}; ajs_user_id=5849596; _hjSessionUser_3508551=eyJpZCI6ImEzZWI2NDU0LTMyM2MtNWI2Mi05OGRhLTc4YzQ4YzU0YTBkNiIsImNyZWF0ZWQiOjE2ODk2ODExMTMyODQsImV4aXN0aW5nIjp0cnVlfQ==; first_visit=1691584457; first_referer=; analytics_session_id=1691584457440; _hjIncludedInSessionSample_3508551=1; _hjSession_3508551=eyJpZCI6ImU2ZjBjMWUzLTQxYjUtNDhjOS05NDU2LTI2NDU1ZWNhNGFiZCIsImNyZWF0ZWQiOjE2OTE1ODQ0NTc1NTksImluU2FtcGxlIjp0cnVlfQ==; _hjAbsoluteSessionInProgress=0; _hjHasCachedUserAttributes=true; intercom-id-fe4ce68d4a8352909f553b276994db414d33a55c=279600f6-9683-4e03-8924-4b529887e6b8; intercom-session-fe4ce68d4a8352909f553b276994db414d33a55c=; intercom-device-id-fe4ce68d4a8352909f553b276994db414d33a55c=b27dd3e3-4d2b-417c-89b7-e27b1b7bc20e; csrf_token=8FVO6_RoIpU2PDXMisCnuk34vMTEp1HD1mQ94ZM1gjA93qTAQ0InmEUNmUr3GuQ6GUIA0du7Lx4kqr-A4uOlAA; _producthunt_session_production=JE55NEDsTi7SOyh0jxlml7DEGjU51ER9%2B5aCfcKQEl7fM%2FP55PfNd%2B3pskTB4S3k8s28J%2F0c27dtDqzIBzlxuUNCilNN4RIA%2B5JLc5uMS3gU4VE84pCPkKCB1Wg5zZXXWqDL7ydAe8k1VPsor8CCopb6cYkZ4ZbsQ4%2Bji5PUbM3amrBSCajuJ%2FhYNFPuOp3tKxajI%2BzwuvI8aDnykO1pldg%2Bck2jNz2Ny1rsWsgbniGPdI6L4krWt0NCxvuEwQXN7yviMSLaSHkbPbaMp47HC0YL8fhipP2cokiVU%2FhL7%2FqpMhiw%2Fc7jUdGyj1xN%2FlPPNLyUy802%2FxRjvMankhtDQNJWSBQgDw7SG8te9uFhBPYWWRCIhA%3D%3D--noWtqu3YhDVn0Y%2BD--hqMnxLlfCsmyqw5%2BYfasJQ%3D%3D; analytics_session_id.last_access=1691584484826; _ga_WZ46833KH9=GS1.1.1691584457.13.1.1691584485.32.0.0' \
-H 'origin: https://www.producthunt.com' \
-H 'referer: https://www.producthunt.com/@pxq85/following' \
-H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
-H 'sec-ch-ua-mobile: ?0' \
-H 'sec-ch-ua-platform: "macOS"' \
-H 'sec-fetch-dest: empty' \
-H 'sec-fetch-mode: cors' \
-H 'sec-fetch-site: same-origin' \
-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
-H 'x-requested-with: XMLHttpRequest' \
--data-raw $'{"operationName":"UserFollowDestroy","variables":{"input":{"userId":"'$1'"}},"query":"mutation UserFollowDestroy($input:UserFollowDestroyInput\u0021){response:userFollowDestroy(input:$input){node{id ...UserFollowButtonFragment __typename}__typename}}fragment UserFollowButtonFragment on User{id followersCount isFollowed __typename}"}' \
--compressed > tmp/pxq85-unfollowed/$1.json




