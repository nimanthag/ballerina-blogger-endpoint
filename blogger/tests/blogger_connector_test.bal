import ballerina/config;
import ballerina/io;
import ballerina/test;

endpoint Client bloggerClient {
    clientConfig: {
        auth: {
            accessToken: config:getAsString("ACCESS_TOKEN"),
            refreshToken: config:getAsString("REFRESH_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET")
        }
    }
};

//
 @test:Config
 function testgetProfileInfo() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getProfileInfo()");

     var details = bloggerClient->getProfileInfo();
     match details {
        ProfileData account => io:println(account.id);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }

 @test:Config
 function testgetProfileInfoOfUser() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getProfileInfoOfUser()");

     var details = bloggerClient->getProfileInfoOfUser("15546761305435177853");
     match details {
        ProfileData account => io:println(account);//.id
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }

 @test:Config
 function testgetgetBlogById() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getBlogById()");

     var details = bloggerClient->getBlogById("3213900");
     match details {
        BlogData bloginfo => io:println(bloginfo);//.posts.totalItems
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }
 @test:Config
 function testgetgetBlogByUrl() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getBlogByUrl()");

     var details = bloggerClient->getBlogByUrl("http://code.blogger.com/");
     match details {
        BlogData bloginfo => io:println(bloginfo);//.posts.totalItems
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }

 @test:Config
 function testgetBlogListByUserId() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getBlogListByUserId()");

     var details = bloggerClient->getBlogListByUserId("15546761305435177853");
     match details {
        BlogList bloglst => io:println(bloglst);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }
 @test:Config
 function testgetPostListByBlogId() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getPostListByBlogId()");

     var details = bloggerClient->getPostListByBlogId("3439810468266050136");
     match details {
        PostList postlst => io:println(postlst);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }
 @test:Config
 function testgetPostByBlogIdAndPostId() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getPostByBlogIdAndPostId()");

     var details = bloggerClient->getPostByBlogIdAndPostId("3439810468266050136","98644116980803936");
     match details {
        Post post => io:println(post);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }

@test:Config
function testdeletePostInABlog() {
    io:println("\n ---------------------------------Test------------------------------------------");
    log:printInfo("bloggerClient->deletePostInABlog()");

    var details = bloggerClient->deletePostInABlog("3439810468266050136","4080112347614943530");
    match details {
        boolean success => io:println("IsSuccess :"+success);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
    }
}

//@test:Config
//function testaddPostToBlog() {
//    io:println("\n ---------------------------------Test------------------------------------------");
//    log:printInfo("bloggerClient->addPostToBlog()");
//    Post postToPublish = new;
//    postToPublish.kind = "blogger#post";
//    postToPublish.blog.id = "3439810468266050136";
//    postToPublish.title = "Post from Ballerina";
//    postToPublish.content = "Ballerina content";
//    postToPublish.author.id = "15546761305435177853";
//    var details = bloggerClient->addPostToBlog("3439810468266050136", postToPublish);
//    match details {
//       Post post => io:println(post);
//       BloggerError bloggerError => {
//           io:println(BloggerError);
//           //test:assertFail(msg = bloggerError.message);
//           }
//    }
//}
@test:Config
 function testgetComment() {
     io:println("\n ---------------------------------Test------------------------------------------");
     log:printInfo("bloggerClient->getComment()");

     var details = bloggerClient->getComment("3439810468266050136","98644116980803936","5769656380834453312");
     match details {
        Comment comment => io:println(comment);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
     }
 }

@test:Config
function testgetCommentListByBlogId() {
    io:println("\n ---------------------------------Test------------------------------------------");
    log:printInfo("bloggerClient->getCommentListByBlogId()");

    var details = bloggerClient->getCommentListByBlogId("3439810468266050136","98644116980803936");
    match details {
        CommentList commentList => io:println(commentList);
        BloggerError bloggerError => test:assertFail(msg = bloggerError.message);
    }
}





