import React, { Component } from 'react'
import { connect } from 'react-redux';
import { userLogin } from 'react-admin';
import PlaidLink from 'react-plaid-link';
import Button from '@material-ui/core/Button';

class LoginPage extends Component {
  handleOnSuccess = (token, metadata) => {
    // Dispatch the userLogin action (injected by connect)
    console.log(this.props);
    this.props.userLogin({token, metadata});
  }
  
  handleOnExit = () => {}

  render() {
    return (
      <div>
        <PlaidLink
          {...this.props}
          clientName="PlaidClearbitApp"
          env="sandbox"
          product={["auth", "transactions"]}
          publicKey={process.env.REACT_APP_PLAID_PUBLIC_KEY}
          onExit={this.handleOnExit}
          onSuccess={this.handleOnSuccess}>
          <Button variant="contained" color="primary">
            Open Link and connect your bank!
          </Button>
        </PlaidLink>
      </div>
    )
  }
}

export default connect(undefined, { userLogin })(LoginPage);
