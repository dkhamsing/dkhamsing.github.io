#!/bin/bash

set -e

git config user.name "Travis CI"
git config user.email "dkhamsing@users.noreply.github.com"

git checkout master

git add index.html

git commit -m "[auto] [ci skip] Update index.html"

git push --quiet "https://${GH_TOKEN}@github.com/dkhamsing/dkhamsing.github.io" master:master > /dev/null 2>&1
