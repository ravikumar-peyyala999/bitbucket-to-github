#!/bin/bash
set -e
repos=$(cat repos.txt)
for repo in $repos; do
  echo
  echo "* Processing $repo..."
  echo
  git clone --bare git@bitbucket.org:$BITBUCKET_ORG/$repo.git 
  cd $repo.git
  echo
  echo "* $repo cloned, now creating on github..."  
  echo
  gh repo create $GITHUB_ORG/$repo --private --confirm
  echo
  echo "* mirroring $repo to github..."  
  echo
  git push --mirror git@github.com:$GITHUB_ORG/$repo.git
  cd ..
  rm -rf $repo.git
done
