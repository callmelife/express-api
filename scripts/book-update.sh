#!/bin/sh
curl --include --request PATCH http://localhost:3000/books/$ID \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "book": {
      "title": "My First Book Updated",
      "author": "Alex K."
    }
  }'
