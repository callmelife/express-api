#!/bin/sh
curl --include --request GET http://localhost:3000/books/$ID \
  --header "Content-Type: application/json"
