
# Ballerina Blogger Endpoint
 ![](https://upload.wikimedia.org/wikipedia/be-x-old/c/c2/Blogger_logo_transparent.png)
[![Build Status](https://travis-ci.org/wso2-ballerina/package-googlespreadsheet.svg?branch=master)](https://travis-ci.org/wso2-ballerina/package-googlespreadsheet)
Blogger is a blog-publishing service that allows multi-user blogs with time-stamped entries.The [Ballerina](http://ballerina.io) Blogger Endpoint enables you to integrate Blogger content with your application using the REST API.

The following sections provide you with information on how to use the Ballerina Blogger endpoint.
- [Compatibility](#compatibility)
- [Authorizing requests and identifying your application](#authorizing-requests-and-identifying-your-application)
  - [About authorization protocols](about-authorization-protocols)
  - [Obtaining Tokens to Run the Sample](obtaining-tokens-to-Run-the-Sample)
- [Prerequisites](prerequisites)
- [Working with Blogger Endpoint actions](Working-with-blogger-endpoint-actions)

### Compatibility

| Ballerina Language Version  | Blogger API Version |
|:---------------------------:|:------------------------------:|
|  0.980.0 ,0.981.1                   |   V3                           |
### Authorizing requests and identifying your application
Every request your application sends to the Blogger APIs needs to identify your application to Google. 
#### About authorization protocols
Your application must use [OAuth 2.0](https://developers.google.com/identity/protocols/OAuth2) to authorize requests. No other authorization protocols are supported. If your application uses [Google Sign-In](https://developers.google.com/identity/#google-sign-in), some aspects of authorization are handled for you.

#### Obtaining Tokens to Run the Sample

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard to create a new project.
2. Go to **Credentials -> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
3. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**. 
4. Select an application type, enter a name for the application, and specify a redirect URI (enter https://developers.google.com/oauthplayground if you want to use 
[OAuth 2.0 playground](https://developers.google.com/oauthplayground) to receive the authorization code and obtain the 
access token and refresh token). 
5. Click **Create**. Your client ID and client secret appear. 
6. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground), select the required Google Spreadsheet scopes, and then click **Authorize APIs**.
7. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh token and access token. 

### Prerequisites
Download the ballerina [distribution](https://ballerinalang.org/downloads/).

### Working with Blogger Endpoint actions
All the actions return valid response or BloggerError. If the action is a success, then the requested resource will be returned. Else BloggerError object will be returned.

In order for you to use the Ballerina Blogger Endpoint, first you need to create a Blogger Client endpoint.In below mention code relevent parameters are read from ballerina.conf file

```ballerina 
ACCESS_TOKEN = "<your_accessToken>"
REFRESH_TOKEN = "<your_refreshToken>"
CLIENT_ID = "<your_clientId>"
CLIENT_SECRET = "<your_clientSecret>"
```

```ballerina
import nimanthag/blogger;

endpoint blogger:Client bloggerClientEP {
    clientConfig: {
        auth: {
            accessToken: config:getAsString("ACCESS_TOKEN"),
            refreshToken: config:getAsString("REFRESH_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET")
        }
    }
};
```

Then the endpoint actions can be invoked as `var response = bloggerClientEP -> actionName(arguments)`.

#### Sample
```ballerina
import ballerina/config;
import ballerina/io;
import nimanthag/blogger;
endpoint blogger:Client bloggerClient {
    clientConfig: {
        auth: {
            accessToken: config:getAsString("ACCESS_TOKEN"),
            refreshToken: config:getAsString("REFRESH_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET")
        }
    }
};
function main(string... args) {

    io:println("\n --------------------main--------------------");
    log:printInfo("bloggerClient->getProfileInfo()");

    var details = bloggerClient->getProfileInfo();
    match details {
        ProfileData self => io:println(self);
        BloggerError bloggerError => io:println(bloggerError);
    }

}
```