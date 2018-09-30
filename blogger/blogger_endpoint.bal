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

import ballerina/http;
import ballerina/config;


# BloggerConfiguration is used to set up the Blogger configuration. In order to use
# this connector, you need to provide the oauth2 credentials.
# + clientConfig - The HTTP client congiguration

public type BloggerConfiguration record{
    http:ClientEndpointConfig clientConfig = {};
};

# Blogger Endpoint object.
# + bloggerConfigs - Blogger client endpoint configuration object
# + bloggerConnector - Blogger connector object
public type Client object {

    public BloggerConfiguration bloggerConfigs = {};
    public BloggerConnector bloggerConnector = new;

    # Blogger endpoint initialization function.
    # + bloggerConfig - Blogger client endpoint configuration object

    public function init(BloggerConfiguration bloggerConfig);


    # Get Blogger connector client.
    # + return - Blogger connector client
    public function getCallerActions() returns BloggerConnector;
};

function Client::init(BloggerConfiguration bloggerConfig) {
    bloggerConfig.clientConfig.url = BASE_URL;
    match bloggerConfig.clientConfig.auth {
        () => {}
        http:AuthConfig authConfig => {
            authConfig.refreshUrl = REFRESH_URL;
            authConfig.scheme = http:OAUTH2;
        }
    }
    self.bloggerConnector.httpClient.init(bloggerConfig.clientConfig);
}

function Client::getCallerActions() returns BloggerConnector {
    return self.bloggerConnector;
}