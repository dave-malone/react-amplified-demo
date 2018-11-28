import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import { Storage } from 'aws-amplify';
import { S3Album } from 'aws-amplify-react';

Storage.configure({ level: 'private' });

class App extends Component {
  
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

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <div className="App">
            <p> Pick a file</p>
            <input type="file" onChange={this.uploadFile} />
            <S3Album level="private" path='' ref={this.albumRef}/>
          </div>
        </header>
      </div>
    );
  }
}

export default App;
