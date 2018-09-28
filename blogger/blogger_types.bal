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

public type Page object{
    string kind;
    string id;
    Blog blog;
    string published;
    string updated;
    string etag;
    string url;
    string selfLink;
    string title;
    string content;
    Author author;
};

public type PageList object{
    string kind;
    Page[] items;
};
//
//"kind": "blogger#page",
//"id": "5683905445280330365",
//"blog": {
//"id": "3439810468266050136"
//},
//"published": "2018-09-28T12:21:00-07:00",
//"updated": "2018-09-28T12:21:34-07:00",
//"etag": "\"iHf3yWDE_geBgZ8U7rgZ_xuTeAQ/dGltZXN0YW1wOiAxNTM4MTYyNDk0NTcxCm9mZnNldDogLTI1MjAwMDAwCg\"",
//"url": "http://kaduruwane.blogspot.com/p/my-first-page.html",
//"selfLink": "https://www.googleapis.com/blogger/v3/blogs/3439810468266050136/pages/5683905445280330365",
//"title": "My first page",
//"content": "Hello guys. How are u",
//"author": {
//"id": "15546761305435177853",
//"displayName": "Jinadasa",
//"url": "https://www.blogger.com/profile/15546761305435177853",
//"image": {
//"url": "//lh3.googleusercontent.com/zFdxGE77vvD2w5xHy6jkVuElKv-U9_9qLkRYK8OnbDeJPtjSZ82UPq5w6hJ-SA=s35"
//}
//}
//}