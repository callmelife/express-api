#!/bin/sh
curl --include --request DELETE http://localhost:3000/books/$ID \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN"
