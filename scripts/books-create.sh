#!/bin/sh
API="http://localhost:4741"
URL_PATH="/"
TOKEN="6jADAH3JlVe2yeBLNviLNaSdxR6J91RevMI+8rLCoXg=--ZkFV7Jx80w+r1yjJpd7mJKCK1a5Nov3gDN3zJqvUYqM="
ID="584f0d708d819f415e281a4a"

curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    }
  }'

API="http://localhost:4741"
URL_PATH="/books"
TOKEN="zA/eKaE59vmn3p7p3HXzO5g7CSEXkbsLSC1oKexpN4U=--81J4nJ0Ab2L4F5PJ5qj9A16x0LBFg8NwlHPuxQ14zDU="
ID="58501bb9178d4c8685af1703"
TITLE="Is this working"
AUTHOR="MATT"
PRICE="10.00"

curl "${API}${URL_PATH}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "book": {
      "title":"'"${TITLE}"'",
      "author":"'"${AUTHOR}"'",
      "price": "'"${PRICE}"'"
    }
  }'

echo
