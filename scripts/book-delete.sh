#!/bin/sh
API="http://localhost:4741"
URL_PATH="/books"
TOKEN="zA/eKaE59vmn3p7p3HXzO5g7CSEXkbsLSC1oKexpN4U=--81J4nJ0Ab2L4F5PJ5qj9A16x0LBFg8NwlHPuxQ14zDU="
ID="58501bb9178d4c8685af1703"

curl "${API}${URL_PATH}/${ID}" \
  --include \
  --request DELETE \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN"
