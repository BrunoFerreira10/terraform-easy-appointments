#!/bin/bash

REGION=$(echo "$1" | xargs)
GITHUB_SECRETS_JSON="$2"

echo "Deleting AWS secret keys..."
echo $GITHUB_SECRETS_JSON | jq -r 'keys[]' | while read key; do
  echo "Deleting secret: $key"
  aws secretsmanager delete-secret --secret-id "$key" --force-delete-without-recovery --region $REGION
done
echo "Secrets deletion process completed."