// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/mime;
import ballerina/http;
import ballerina/io;
import ballerina/config;
import ballerina/log;


documentation {Blogger client connector
    F{{httpClient}} - The HTTP Client
}
public type BloggerConnector object {
    //public {
        public http:Client httpClient = new;
   // }

    documentation {Get Profile Information
        R{{}} - ProfileData object on success and BloggerError on failure
    }
    function getProfileInfo() returns ProfileData|BloggerError;

    documentation {Get Profile Information of a user
        P{{userId}} - A unique identifier for the user
        R{{}} - ProfileData object on success and BloggerError on failure
    }
    function getProfileInfoOfUser(string userId) returns ProfileData|BloggerError;

    documentation {Get Blog Information from unique Id
    P{{blogId}} - A unique identifier for the blog
    R{{}} - BlogData object on success and BloggerError on failure
    }
    function getBlogById(string blogId) returns BlogData|BloggerError;

    documentation {Get Blog Information from url
    P{{blogUrl}} - A unique Url for the blog
    R{{}} - BlogData object on success and BloggerError on failure
    }
    function getBlogByUrl(string blogUrl) returns BlogData|BloggerError;

    documentation {Get BlogList of a user
    P{{userId}} - A unique identifier for the user
    R{{}} - BlogList object on success and BloggerError on failure
    }
    function getBlogListByUserId(string userId) returns BlogList|BloggerError;

    documentation {Get PostList of a blog
    P{{blogId}} - A unique identifier for the blog
    R{{}} - PostList object on success and BloggerError on failure
    }
    function getPostListByBlogId(string blogId) returns PostList|BloggerError;

    documentation {Get Post of a blog using blog id and post id
    P{{blogId }} - A unique identifier for the blog
    P{{postId}} - A uniqhue identifier for the post in a blog
    R{{}} - PostList object on success and BloggerError on failure
    }
    function getPostByBlogIdAndPostId(string blogId, string postId) returns Post|BloggerError;

    documentation {Add a post to a blog
    P{{blogId }} - A unique identifier for the blog
    P{{post }} - A post object which need to publish
    R{{}} - Post object on success and BloggerError on failure
    }
    function addPostToBlog(string blogId, Post post) returns Post|BloggerError;

    documentation { Delete a post in a blog
    P{{blogId }} - A unique identifier of the blog
    P{{postId }} - A unique identifier of the post
    R{{}} - boolean on success and BloggerError on failure
    }
    function deletePostInABlog(string blogId, string postId) returns boolean|BloggerError;

    // Need to write description in new format
    function getComment(string blogId, string postId, string commentId) returns Comment|BloggerError;

    function getCommentListByBlogId(string blogId, string postId) returns CommentList|BloggerError;

    function getJasonObject (string url) returns json|BloggerError;

    function postJasonObject(string url, json payload) returns json|BloggerError;

    function deleteObject(string url) returns boolean|BloggerError;
};
function BloggerConnector::deleteObject(string url) returns boolean|BloggerError{
    endpoint http:Client httpClient = self.httpClient;
    BloggerError bloggerError = new;
    http:Request request = new;
    var httpResponse = httpClient->delete(url,request);
    match httpResponse {
        error err => {
            bloggerError.message = err.message;
            bloggerError.cause = err.cause;
            log:printError(bloggerError.message, err = ());
            return bloggerError;
        }
        http:Response response => {

            int statusCode = response.statusCode;

            if (statusCode == http:NO_CONTENT_204) {
                return true;
            } else {
                bloggerError.message = "Deletion fail";
                bloggerError.statusCode = statusCode;
                log:printError(bloggerError.message, err = ());
                return bloggerError;
            }
        }
    }
}
function BloggerConnector::postJasonObject (string url, json payload) returns json|BloggerError {
    endpoint http:Client httpClient = self.httpClient;
    BloggerError bloggerError = new;
    http:Request request = new;
    request.setJsonPayload(payload);
    io:println(request);
    io:println("url :"+url);
    //io:println(httpClient);
    var httpResponse = httpClient->post(url, request );
    match httpResponse {
        error err => {
            bloggerError.message = err.message;
            bloggerError.cause = err.cause;
            log:printError(bloggerError.message, err = ());
            return bloggerError;
        }
        http:Response response => {
    
            int statusCode = response.statusCode;
            var bloggerJSONResponse = response.getJsonPayload();
            match bloggerJSONResponse {
                error err => {
                    bloggerError.message = "Error occured while extracting Json Payload";
                    bloggerError.cause = err.cause;
                    log:printError(bloggerError.message, err = ());
                    return bloggerError;
                }
                json jsonResponse => {
                    if (statusCode == http:OK_200) {
                        return jsonResponse;
                    } else {
                        bloggerError.message = jsonResponse["errors"].toString();
                        bloggerError.statusCode = statusCode;
                        log:printError(bloggerError.message, err = ());
                        return bloggerError;
                    }
                }
            }
        }
    }  
}

function BloggerConnector::getJasonObject (string url) returns json|BloggerError {
      endpoint http:Client httpClient = self.httpClient;
    BloggerError bloggerError = new;
    var httpResponse = httpClient->get(url);
    match httpResponse {
        error err => {
            bloggerError.message = err.message;
            bloggerError.cause = err.cause;
            log:printError(bloggerError.message, err = ());
            return bloggerError;
        }
        http:Response response => {
    
            int statusCode = response.statusCode;
            var bloggerJSONResponse = response.getJsonPayload();
            match bloggerJSONResponse {
                error err => {
                    bloggerError.message = "Error occured while extracting Json Payload";
                    bloggerError.cause = err.cause;
                    log:printError(bloggerError.message, err = ());
                    return bloggerError;
                }
                json jsonResponse => {
                    if (statusCode == http:OK_200) {
                        return jsonResponse;
                    } else {
                        bloggerError.message = jsonResponse["errors"].toString();
                        bloggerError.statusCode = statusCode;
                        log:printError(bloggerError.message, err = ());
                        return bloggerError;
                    }
                }
            }
        }
    }  
}
function BloggerConnector::getProfileInfo() returns ProfileData |BloggerError {

    ProfileData bloggerResponse;
    var response = self.getJasonObject(USERS_PATH+ME);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToProfileData(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }

}
function BloggerConnector::getProfileInfoOfUser(string userId)returns ProfileData |BloggerError {
    ProfileData bloggerResponse;
    var response = self.getJasonObject(USERS_PATH+userId);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToProfileData(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        } 
    }
}

function BloggerConnector::getBlogById(string blogId) returns BlogData|BloggerError{
    BlogData bloggerResponse;
    var response = self.getJasonObject(BLOGS+blogId);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToBlogData(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }

}


function BloggerConnector::getBlogByUrl(string blogUrl) returns BlogData|BloggerError{
    BlogData bloggerResponse;
    io:println(BLOGS+BY_URL+blogUrl);
    var response = self.getJasonObject("/blogs/byurl?url="+blogUrl);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToBlogData(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }
}

function BloggerConnector::getBlogListByUserId(string userId) returns BlogList|BloggerError{

    BlogList bloggerResponse;
    var response = self.getJasonObject(USERS_PATH+userId+BLOGS);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToBlogList(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }
}

function BloggerConnector::getPostListByBlogId(string blogId) returns PostList|BloggerError{
    PostList bloggerResponse;
    var response = self.getJasonObject(BLOGS+blogId+BLOG_POST);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToPostList(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }
}

function BloggerConnector::getPostByBlogIdAndPostId(string blogId, string postId) returns Post|BloggerError{
    Post bloggerResponse;
    var response = self.getJasonObject(BLOGS+blogId+BLOG_POST+postId);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToPost(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }
}
function BloggerConnector::addPostToBlog(string blogId, Post post) returns Post|BloggerError {
    json payload = convertPostToJason(post);
    io:println(payload);
    string url = BLOGS+blogId+BLOG_POST;
    var response = self.postJasonObject(url, payload);
    Post bloggerResponsePost;
    match response {
        json  bloggerResponse=>{
            bloggerResponsePost= convertToPost(bloggerResponse);
            return bloggerResponsePost;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }

}
function BloggerConnector::deletePostInABlog(string blogId, string postId) returns boolean|BloggerError{
    string url = BLOGS+blogId+BLOG_POST+postId;
    match self.deleteObject(url) {
        boolean value => {
            log:printDebug("Deleting success");
            return value;
        }
        BloggerError err =>{
            return err;
        }

    }
}

function BloggerConnector::getComment(string blogId, string postId, string commentId) returns Comment|BloggerError{
    Comment bloggerResponse;
    var response = self.getJasonObject(BLOGS+blogId+BLOG_POST+postId+COMMENT+commentId);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToComment(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }

}

function BloggerConnector::getCommentListByBlogId(string blogId, string postId) returns CommentList|BloggerError{
    CommentList bloggerResponse;
    var response = self.getJasonObject(BLOGS+blogId+BLOG_POST+postId+COMMENT);
    match response {
        json jasonResponse=> {
            bloggerResponse = convertToCommentList(jasonResponse);
            return bloggerResponse;
        }
        BloggerError blogerr=>{
            return blogerr;
        }
    }
}