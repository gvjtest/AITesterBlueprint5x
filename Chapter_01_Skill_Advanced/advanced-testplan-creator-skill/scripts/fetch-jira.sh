#!/bin/bash

# ==============================================================================
# Script: fetch-jira.sh
# Description: Fetches Jira ticket details using Jira REST API
# Usage:
#   ./fetch-jira.sh [TICKET_KEY_OR_URL]
#
# Examples:
#   ./fetch-jira.sh
#   ./fetch-jira.sh JIRA-1234
#   JIRA_BASE_URL="https://your-domain.atlassian.net" \
#   JIRA_EMAIL="your-email@example.com" \
#   JIRA_API_TOKEN="your-api-token" \
#   ./fetch-jira.sh JIRA-1234
# ==============================================================================

set -euo pipefail

# Load .env file if available
for ENV_PATH in ".env" "../.env" "../../.env" "../../../.env"; do
  if [ -f "$ENV_PATH" ]; then
    set -a
    # shellcheck disable=SC1090
    source "$ENV_PATH"
    set +a
    break
  fi
done

# Configuration (override with environment variables or edit directly)
JIRA_BASE_URL="${JIRA_BASE_URL:-https://atlassian.net}"
JIRA_EMAIL="${JIRA_EMAIL:-your-email@example.com}"
JIRA_API_TOKEN="${JIRA_API_TOKEN:-YOUR_API_TOKEN}"

# Optional argument: ticket key (e.g., JIRA-1234) or full URL
TICKET="${1:-}"

if [ -z "$TICKET" ]; then
  URL="$JIRA_BASE_URL"
elif [[ "$TICKET" =~ ^https?:// ]]; then
  URL="$TICKET"
else
  URL="${JIRA_BASE_URL%/}/rest/api/3/issue/${TICKET}"
fi

curl --request GET \
  --url "$URL" \
  --user "${JIRA_EMAIL}:${JIRA_API_TOKEN}" \
  --header "Accept: application/json"

