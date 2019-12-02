#!/bin/bash

echo Installing NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm --version 

echo Installing Node 
nvm install --lts

echo Installing Yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install -y yarn


echo Upgrading AWS CLI
pip install awscli --upgrade --user

npm install -g @aws-amplify/cli

echo "Creating Symlink for Cloud9 & Amplify..."
ln -s ~/.aws/credentials ~/.aws/config


echo "node version: $(node --version)"
echo "npm version: $(npm --version)"
echo "nvm version: $(nvm --version)"
echo "yarn version: $(yarn --version)"
echo "awscli version: $(aws --version)"
echo "amplify version: $(amplify --version)"

echo "Environment initialized"