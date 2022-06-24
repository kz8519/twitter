//
//  User.h
//  twitter
//
//  Created by Kathy Zhong on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

// MARK: Properties

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying

// Add any additional properties here
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *numTweets;
@property (nonatomic, strong) NSString *numFollowing;
@property (nonatomic, strong) NSString *numFollowers;
@property (nonatomic, strong) NSString *bannerPicture;



// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
