
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
6. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground), select the required Google Blogger scopes, and then click **Authorize APIs**.
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

## Examples
First, import the `nimanthag/blogger` package into the Ballerina project.
```ballerina
import nimanthag/blogger;
```
Instantiate the connector by giving authentication details in the HTTP client config, which has built-in support for 
BasicAuth and OAuth 2.0. Blogger uses OAuth 2.0 to authenticate and authorize requests. The Ballerina end point client can be 
minimally instantiated in the HTTP client config using the access token or using the client ID, client secret, 
and refresh token.

You can now enter the credentials in the HTTP client config. 
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
Then the endpoint actions can be invoked as var response = bloggerClientEP -> actionName(arguments). All the actions return valid response or BloggerError. If the action is a success, then the requested resource will be returned. Else BloggerError object will be returned.



### Retreive self profile information
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
The response from `getProfileInfo` is either a ProfileData object (if successfully) or a `BloggerError` (if unsuccessful). The `match` operation can be used to handle the response if an error occurs.

### Retreive user profile information
You can retrieve a user's information by 
```ballerina
     log:printInfo("bloggerClient->getProfileInfoOfUser()");

     var details = bloggerClient->getProfileInfoOfUser("1234567"); //unique user id
     match details {
        ProfileData account => io:println(account);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
```
### Working with blogs
#### Search
##### by blog id
You can retrieve information for a particular blog by
```ballerina
     var details = bloggerClient->getBlogById("3213900"); //unique blog id
     match details {
        BlogData bloginfo => io:println(bloginfo);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
```
##### by blog url
You can retrieve information for a particular blog by 
```ballerina
     var details = bloggerClient->getBlogByUrl("http://code.blogger.com/");
     match details {
        BlogData bloginfo => io:println(bloginfo);//.posts.totalItems
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
```
##### by user id
You can retrieve a list of a user's blogs by
```ballerina
     var details = bloggerClient->getBlogListByUserId("12345566"); //unique user id
     match details {
        BlogList bloglst => io:println(bloglst);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
```
### Working with posts
#### Search
##### by blog id
You can retrieve a list of posts by
```ballerina
     var details = bloggerClient->getPostListByBlogId("3123567"); // unique blog id
     match details {
        PostList postlst => io:println(postlst);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
```
##### by blog id and post id
You can retrieve a specific post by
```ballerina
     var details = bloggerClient->getPostByBlogIdAndPostId("34398104682660501376","986441186980803936"); // blog id , post id
     match details {
        Post post => io:println(post);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
```
#### Delete 
##### by blog id and post id
You can delete a post in a blog by
```ballerina
    var details = bloggerClient->deletePostInABlog("34398104682660501346","40801123478614943530"); // blog id ,post id
    match details {
        boolean success => io:println("IsSuccess :"+success);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
    }
```
### Working with comments
#### Search
##### by blog id and post id
You can retrieve a list of comments for a post by
```ballerina
    var details = bloggerClient->getCommentList("34398104682660556","986441169808035"); // blog id, post id
    match details {
        CommentList commentList => io:println(commentList);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
    }
```
##### by blog id, post id and comment id
You can retrieve a specific comment from a post by
```ballerina
     var details = bloggerClient->getComment("3439810468266052345430136","98644113216980803936","576961243256380834453312"); // blog id, post id, comment id
     match details {
        Comment comment => io:println(comment);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
```
### Working with pages
####  Search
##### by blog id
You can retrieve a list of pages for a blog by
```ballerina
    var details = bloggerClient->getPageList("343981046826605013456"); //blog id
    match details {
        PageList pageList => io:println(pageList);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
    }
```
##### by blog id and page id
You can retrieve a specific page from a blog by
```ballerina
    var details = bloggerClient->getPage("3439810450136","8543006282311"); // blog id, page id
    match details {
        Page page => io:println(page);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
    }
```


