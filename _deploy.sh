#!/bin/sh

set -e

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "caelan.yang@gmail.com"
git config --global user.name "caelanyang"

git clone -b book-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git book-output
cd book-output
cp -r ../_book/* ./
git add --all *
echo "https://dsbook.netlify.com/* https://ds.jiacheng.site/:splat 301!" > _redirects
git add _redirects
git commit -m"Update the book" || true
git push -q origin book-pages
