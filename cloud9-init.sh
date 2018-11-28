#!/bin/bash

echo Installing NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm --version 

echo Installing Node 
nvm install node
node --version

echo Installing Yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install yarn
yarn --version

echo Installing Amplify CLI
npm install -g @aws-amplify/cli

echo Upgrading AWS CLI
pip install awscli --upgrade --user