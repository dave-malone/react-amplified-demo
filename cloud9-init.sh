#!/bin/bash

echo Installing NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm --version 

echo Installing Node 
nvm install node
nvm use node 
nvm alias default node
node --version

echo Installing Yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install -y yarn
yarn --version

echo Installing Amplify CLI
npm install -g @aws-amplify/cli

echo Upgrading AWS CLI
pip install awscli --upgrade --user

nvm --version
node --version
yarn --version
amplify --version
aws --version