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


#Struct to define Locale.
# + language - language of the Blogger
# + country - country of the Blogger
# + variant - variant of the Blogger

type Locale record {
    string language;
    string country;
    string variant;
};

# Struct to define Blogs.
# + selfLink - self link

type Blogs record{
    string selfLink;
};

# Struct to define Posts.
# + totalItems - No of posts
# + selfLink - self link
public type Posts record{
string totalItems;
string selfLink;
};

# Struct to define Pages.
# + totalItems - No of pages
# + selfLink - self link
public type Pages record{
string totalItems;
string selfLink;
};

# Struct to define Blog.
# + id - Unique identifier
public type Blog record{
string id;
};


# Struct to define PostID.
# + id - Unique identifier
public type PostID record{
string id;
};

# Struct to define Image.
# + url - image url
public type Image record{
string url;
};

# Struct to define Replies.
# + totalItems - no of replies
# + selfLink - self link
public type Replies record{
string totalItems;
string selfLink;
};


# Struct to define Author.
# + id - Unique identifier of author
# + displayname - Display name of author
# + url - url of the author
# + image - Image object
public type Author record{
string id;
string displayname;
string url;
Image image;
};

# Struct to define ProfileData.
# + kind - The user’s kind on Blogger
# + id - A unique identifier for the Blogger
# + url - The URL to the user’s profile on Blogger
# + selfLink - self link
# + blogs - refers to Blogs
# + displayName - The user’s name on Blogger
# + locale - contains locale

public type ProfileData object{
    string kind;
    string id;
    string url;
    string selfLink;
    Blogs blogs;
    string displayName;
    Locale locale;
    

};

# Struct to define BlogData.
# + kind - kind
# + id - A unique identifier for the blog
# + name - Name
# + description - Description of the blog
# + published - publish date
# + updated - update date
# + url - The URL to the blog
# + selfLink - self link
# + posts - Posts object
# + pages - Pages object
# + locale - contains locale
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

# Struct to define BlogList.
# + kind - kind
# + items - list of BlogData objects
public type BlogList object {
string kind;
BlogData[] items;
};


# Struct to define Post.
# + kind - kind
# + id - A unique identifier for the post
# + blog - Blog object
# + published - publish date
# + updated - update date
# + url - The URL to the blog
# + selfLink - self link
# + title - Title of the post
# + content - Content in the post
# + author - Author of the post
# + replies - Replies object
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

# Struct to define PostList.
# + kind - kind
# + nextPageToken - Token for the next page
# + prevPageToken - Token for the previous page
# + items - List of Posts
public type PostList object{
string kind;
string nextPageToken;
string prevPageToken;
Post[] items;
} ;

# Struct to define Comment.
# + kind - kind
# + id - A unique identifier for the comment
# + post - PostID object
# + blog - Blog object
# + published - publish date
# + updated - update date
# + selfLink - self link
# + content - Content in the post
# + author - Author of the post
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

# Struct to define CommentList.
# + kind - kind
# + nextPageToken - Token for the next page
# + prevPageToken - Token for the previous page
# + items - List of Comments
public type CommentList object{
    string kind;
    string nextPageToken;
    string prevPageToken;
    Comment[] items;
};

# Struct to define Page.
# + kind - kind
# + id - A unique identifier for the Page
# + blog - Blog object
# + published - publish date
# + updated - update date
# + etag - Electronic Tag
# + url - The URL to the page
# + selfLink - self link
# + title - Title of the post
# + content - Content in the post
# + author - Author of the post
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

# Struct to define PageList.
# + kind - kind
# + items - List of Pages
public type PageList object{
    string kind;
    Page[] items;
};

# Struct to define the error.
# + message - Error message of the response
# + cause - The error which caused the Blogger error
# + statusCode - The status code
public type BloggerError object{
string message;
error? cause;
int statusCode;
};