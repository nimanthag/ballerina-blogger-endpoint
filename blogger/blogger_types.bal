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

documentation { record to define Locale
    F{{language}} language of the Blogger
    F{{country}} country of the Blogger
    F{{variant}} variant of the Blogger
}
type Locale record {
    string language,
    string country,
    string variant,
};

type Blogs record{
    string selfLink;
};
documentation {Struct to define the Profile Data
    F{{id}} A unique identifier for the Blogger
    F{{kind}} The user’s kind on Blogger
    F{{displayName}} The user’s name on Blogger
    F{{url}} The URL to the user’s profile on Blogger
    F{{selfLink}} The user's Self Link on Blogger
    F{{locale}} record contains language country and variant
    F{{blogs}} record contains Blogs selfLink
}
public type ProfileData object{
    string kind;
    string id;
    string url;
    string selfLink;
    Blogs blogs;
    string displayName;
    Locale locale;
    

};
public type Posts record{
    string totalItems;
    string selfLink;
};
public type Pages record{
    string totalItems;
    string selfLink;
};
public type BlogData object{
    string kind;
    string id;
    string name;
    string description;
    string published;
    string updated;
    string url;
    string selfLink;
    Posts posts;
    Pages pages;
    Locale locale;
};

documentation {Struct to define the error
    F{{message}} - Error message of the response
    F{{cause}} - The error which caused the Blogger error
    F{{statusCode}} - The status code
}
public type BloggerError object{
    string message;
    error? cause;
    int statusCode;
};

public type BlogList object {
    string kind;
    BlogData[] items;
};

public type Blog record{
    string id;
};

public type PostID record{
    string id;
};

public type Author record{
    string id;
    string displayname;
    string url;
    Image image;
};

public type Image record{
    string url;
};

public type Replies record{
    string totalItems;
    string selfLink;
};
public type Post object{
    string kind;
    string id;
    Blog blog;
    string published;
    string updated;
    string url;
    string selfLink;
    string title;
    string content;
    Author author;
    Replies replies;
};
public type PostList object{
    string kind;
    string nextPageToken;
    string prevPageToken;
    Post[] items;
} ;

public type Comment object {
    string kind;
    string id;
    PostID post;
    Blog blog;
    string published;
    string updated;
    string selfLink;
    string content;
    Author author;
};

public type CommentList object{
    string kind;
    string nextPageToken;
    string prevPageToken;
    Comment[] items;
};

//{
//"kind": "blogger#comment",
//"id": "9200761938824362519",
//"post": {
//"id": "6069922188027612413"
//},
//"blog": {
//"id": "2399953"
//},
//"published": "2011-07-28T19:19:57.740Z",
//"updated": "2011-07-28T21:29:42.015Z",
//"selfLink": "https://www.googleapis.com/blogger/v3/blogs/2399953/posts/6069922188027612413/comments/9200761938824362519",
//"content": "elided",
//"author": {
//"id": "530579030283",
//"displayName": "elided",
//"url": "elided",
//"image": {
//"url": "elided"
//}
//}
//}