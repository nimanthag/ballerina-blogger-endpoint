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

function convertToProfileData(json jsonDatas) returns ProfileData {

    ProfileData data = check <ProfileData>jsonDatas;
    return data;
}

function convertToBlogData(json jsonDatas) returns BlogData {

    BlogData data = check <BlogData>jsonDatas;
    return data;
}

function convertToInt(json jsonVal) returns int {
    string stringVal = jsonVal.toString();
    if (stringVal != "") {
        return check <int>stringVal;
    } else {
        return 0;
    }
}

function convertToArray(json jsonValues) returns string[] {
    string[] tags = [];
    int i = 0;
    foreach jsonVal in jsonValues {
        tags[i] = jsonVal.toString();
        i = i + 1;
    }
    return tags;
}

function convertToBlogList(json jsonDatas) returns BlogList {

    BlogList data = check <BlogList>jsonDatas;
    return data;
}

function convertToPostList(json jsonDatas) returns PostList {

    PostList data = check <PostList>jsonDatas;
    return data;
}

function convertToPost(json jsonDatas) returns Post {

    Post data = check <Post>jsonDatas;
    return data;
}