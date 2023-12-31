#!/bin/bash
# provoding git credentials
GIT_USERNAME='satishkollati'
GIT_PASSWORD='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'
bbname='satishkollati'
WORKSPACE='codepipeline9'
#read -p 'Enter the  GIT username: ' GIT_USERNAME
#read -p 'Enter the  GIT PASSWD: ' GIT_PASSWORD

# Setting a mirror of source repository
#read -p 'Enetr your bb name: ' bbname
#read -p 'Enter the workspace name: ' WORKSPACE

#read -p 'Enter the repo name: ' REPO

echo
for REPO in  ravi test_migration poc ;
do
echo "... Processing $REPO ..."

#git clone --mirror git@bitbucket.org:$WORKSPACE/$REPO.git
git clone https://$bbname@bitbucket.org/$WORKSPACE/$REPO.git

cd $REPO

if [ $? -ne 0 ]; then
   echo " changed to ${REPO}"
   exit 1
fi      
echo

echo "... $REPO cloned, now creating on github ..."
echo

# Creating a repository on github
curl -u $GIT_USERNAME:$GIT_PASSWORD https://api.github.com/user/repos \
     -d "{\"name\": \"$REPO\", \"private\": true}"
echo
echo "... Mirroring $REPO to github ..."
echo

# Pushing mirror to github repository
git push --mirror git@github.com:$GIT_USERNAME/$REPO.git
cd ..
# Clean up the local repository
cd ..
echo "$REPO Repository Migration is completed successfully!"

done