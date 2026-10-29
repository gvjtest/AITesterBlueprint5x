This is the curl request which can fetch the Jira ticket from my company - create a fetch-jira.sh file in the scripts folder 
curl --request GET \
  --url "https://atlassian.net" \
  --user "your-email@example.com:YOUR_API_TOKEN" \
  --header "Accept: application/json"