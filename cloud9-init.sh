#!/bin/bash

echo Installing NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

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


echo Upgrading AWS CLI
pip install awscli --upgrade --user

echo "nvm version: $(nvm --version)"
echo "node version: $(node --version)"
echo "yarn version: $(yarn --version)"
echo "awscli version: $(aws --version)"