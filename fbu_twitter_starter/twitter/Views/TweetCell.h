//
//  TweetCell.h
//  twitter
//
//  Created by Kathy Zhong on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profileView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screennameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (nonatomic, strong) Tweet *tweet; // For favoriting, retweeting & replying
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UIButton *replyButton;


@end

NS_ASSUME_NONNULL_END
