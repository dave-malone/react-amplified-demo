The following demonstration includes the use of AWS Cloud9, a cloud-based IDE, to build a fully serverless cloud native application in React using the Amplify toolchain as well as the Amplify Javascript library.

Through this demo, you will see how easy it is to build a fully functional, secure cloud native application in hours rather than in days or weeks.

AWS Amplify is a Javascript library for frontend and mobile developers building cloud-enabled applications. The default implementation works with AWS, but it is designed to be open and pluggable for any custom backend or service.


## Cloud9 Setup

When starting with a fresh Cloud9 environment, you will need to install a few tools for use with this demo. 

```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm --version 

# Install Node 
nvm install node
node --version

# Install Yarn
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install yarn
yarn --version

# Install Amplify CLI
npm install -g @aws-amplify/cli

# Upgrade AWS CLI
pip install awscli --upgrade --user
```

### Configure your environment for use with the Amplify CLI

```
amplify configure
```

### Create the project React project and begin integrating with AWS via Amplify
1. `yarn create react-app myapp`
2. `cd myapp`
3. `amplify init`
4. `amplify run`
5. `amplify add hosting`
6. `amplify status`
7. `amplify publish`
8. `amplify run`
9. At this point, there's nothing really interesting about this app. Let's require auth for accessing our webapp, and add user signup / signin capabilities

### Enable User Signup / Signin
1. `amplify add auth`
2. `amplify push` If you do not run this command, the `aws-exports.js` file needed in the next steps will not get generated
3. `yarn add aws-amplify aws-amplify-react`
4. in index.js add:
  ```javascript
  import Amplify from 'aws-amplify'
  import config from './aws-exports'
  import { withAuthenticator } from 'aws-amplify-react';
  Amplify.configure(config);
  const AppWithAuth = withAuthenticator(App);
  ReactDOM.render(<AppWithAuth />, document.getElementById('root'));
  ```
5. `amplify publish`
6. What if users want to use their existing identity? No problem. In index.js:
  ```javascript
  const federated = {
    google_client_id: '',
    facebook_app_id: '',
    amazon_client_id: ''
  };

  ReactDOM.render(<AppWithAuth federated={federated} />, document.getElementById('root'));  
  ```
7. Our users can now sign up and sign in. Sadly, they can't sign out.
8. in index.js:
  ```javascript
  const AppWithAuth = withAuthenticator(App, { includeGreetings: true });
  ```



### Create an S3 backed photo album
1. `amplify add storage`
2. `amplify push`
3. `amplify run`
4. in App.js add:
  ```javascript
  import { Storage } from 'aws-amplify';
  import { S3Album } from 'aws-amplify-react';
  
  Storage.configure({ level: 'private' });
  ...

  constructor(props) {
    super(props)
    this.albumRef = React.createRef()
  }
  
  uploadFile = (evt) => {
    const file = evt.target.files[0];
    const key_prefix = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15)
    const key = `${key_prefix}-${file.name}`
  
    Storage.put(key, file).then(() => {
      this.albumRef.current.list()
    })
  }

  ...
    render() {
        return (
          <div className="App">
            <p> Pick a file</p>
            <input type="file" onChange={this.uploadFile} />
            <S3Album level="private" path='' ref={this.albumRef}/>
          </div>
      )
    }
  ```
5. `amplify publish`

 




## Resources

* [AWS Amplify Documenttion](https://aws-amplify.github.io/docs)
* [AWS Amplify Projects on Github](https://github.com/aws-amplify)
* [nvm installation instructions](https://github.com/creationix/nvm#installation)
* [create-react-app Documentation](https://github.com/facebook/create-react-app)
* [yarn installation instructions](https://yarnpkg.com/lang/en/docs/install/)
