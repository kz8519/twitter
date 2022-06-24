//
//  User.m
//  twitter
//
//  Created by Kathy Zhong on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = [NSString stringWithFormat:@"%@%@", @"@", dictionary[@"screen_name"]];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        
        // Initialize any other properties
        self.idStr = dictionary[@"id_str"];
        self.tagline = dictionary[@"description"];
        self.numTweets = [NSString stringWithFormat:@"%@", dictionary[@"statuses_count"]];
        self.numFollowing = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
        self.numFollowers = [NSString stringWithFormat:@"%@", dictionary[@"followers_count"]];
        self.bannerPicture = dictionary[@"profile_banner_url"];
    }
    return self;
}

@end
