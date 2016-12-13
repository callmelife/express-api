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
