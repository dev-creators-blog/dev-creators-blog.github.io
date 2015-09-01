#!/bin/bash

branch=`git rev-parse --abbrev-ref @`
if [ "$branch" = "master" ]; then
  echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

  # Build the project.
  hugo

  # Add changes to git.
  git add -A public

  # Commit changes.
  msg="rebuilding site `date`"
  if [ $# -eq 1 ]; then
    msg="$1"
  fi
  git commit -m "$msg"

  # Push source and build repos.
  git push origin master 
  git subtree push --prefix=public origin gh-pages 

else
  echo -e "\033[0;31merror: Current branch is not a gh-pages.\033[0m" 1>&2
  exit 1
fi

exit 0
