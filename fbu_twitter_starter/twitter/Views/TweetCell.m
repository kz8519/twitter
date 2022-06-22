//
//  TweetCell.m
//  twitter
//
//  Created by Kathy Zhong on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.usernameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = self.tweet.user.screenName;
    self.timestampLabel.text = self.tweet.createdAtString;
    self.tweetTextLabel.text = self.tweet.text;
    self.profileView = nil;
    if (self.tweet.user.profilePicture != nil) {
        [self.profileView setImageWithURL:self.tweet.user.profilePicture];
    }
    
    NSLog(@"%@", self.tweetTextLabel.text);
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)retweenBtn:(id)sender {
}

- (IBAction)replyBtn:(id)sender {
}

- (IBAction)favoriteBtn:(id)sender {
}
@end
