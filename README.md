# DOP334-R - Cloud Native App Dev with AWS Amplify and React


![Github Repo URL](https://chart.googleapis.com/chart?cht=qr&chl=https%3A%2F%2Fgithub.com%2Fdave-malone%2Freact-amplified-demo&chs=180x180&choe=UTF-8&chld=L|2)

### https://git.io/JeD21


The following demonstration includes the use of AWS Cloud9, a cloud-based IDE, to build a fully serverless cloud native application in React using the Amplify toolchain as well as the Amplify Javascript library.

Through this demo, you will see how easy it is to build a fully functional, secure cloud native application in hours rather than in days or weeks.

AWS Amplify is a Javascript library for frontend and mobile developers building cloud-enabled applications. The default implementation works with AWS, but it is designed to be open and pluggable for any custom backend or service.


## Cloud9 Setup

When starting with a fresh Cloud9 environment, you will need to install a few tools for use with this demo. A convenience script has been included with this repo to help you get up and running. 

```bash
git clone https://github.com/dave-malone/react-amplified-demo dop334
curl -s -L https://git.io/JeM6t | bash
```

### Install Amplify and Configure your environment for use with the Amplify CLI

```bash 
npm install -g @aws-amplify/cli
echo "amplify version: $(amplify --version)"
amplify configure
```


### Create the project React project and begin integrating with AWS via Amplify
1. `yarn create react-app react-amplified`
2. `cd react-amplified`
3. `amplify init`
4. `amplify run`
5. `amplify add hosting`
6. `amplify status`
7. `amplify publish`
8. At this point, there's nothing really interesting about this app. Let's require auth for accessing our webapp, and add user signup / signin capabilities

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
3. Replace the contents of App.js with:
  ```javascript
import React, { Component } from 'react';
import './App.css';
import { Storage } from 'aws-amplify';
import { S3Album } from 'aws-amplify-react';

Storage.configure({ level: 'private' });

class App extends Component {
  
  constructor(props){
    super(props)
    this.albumRef = React.createRef()
    this.uploadFile = this.uploadFile.bind(this);
  }
  
  uploadFile = (evt) => {
    const file = evt.target.files[0];
    const key_prefix = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15)
    const key = `${key_prefix}-${file.name}`
  
    Storage.put(key, file).then(() => {
      this.albumRef.current.list()
    })
  }
  
  render() {
    return (
        <div className="App">
          <p> Pick a file</p>
          <input type="file" onChange={this.uploadFile} />
          <S3Album level="private" path='' ref={this.albumRef}/>
        </div>
    )
  }
}

export default App;
  ```
4. `amplify publish`

### Cleanup

1. `amplify delete`
2. Delete S3 buckets
3. Delete IAM user amplify-*
4. Delete Cloud9 Instance


## Resources

* [AWS Amplify Documenttion](https://aws-amplify.github.io/docs)
* [AWS Amplify Projects on Github](https://github.com/aws-amplify)
* [nvm installation instructions](https://github.com/creationix/nvm#installation)
* [create-react-app Documentation](https://github.com/facebook/create-react-app)
* [yarn installation instructions](https://yarnpkg.com/lang/en/docs/install/)
