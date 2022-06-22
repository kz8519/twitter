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
    
    // set profile image
    // https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
    self.profileView.image = nil;
    if (self.tweet.user.profilePicture != nil) {
        
        NSString *URLString = self.tweet.user.profilePicture;
        NSURL *url = [NSURL URLWithString:URLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        self.profileView.image = [UIImage imageWithData:urlData];
    }

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
