//
//  TweetCell.m
//  twitter
//
//  Created by Kathy Zhong on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "DateTools.h"

@implementation TweetCell

- (IBAction)didTapRetweet:(id)sender {
    
    // Update the local tweet model and cell UI
    if ([sender isSelected]) { // from retweeted --> unretweeted
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [sender setTitle:@(self.tweet.retweetCount).stringValue forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        
        [sender setSelected:NO];
        
        // Send a POST request to the POST retweets/create endpoint
        // Call the unretweet(completion:) method and pass in the tweet to be unretweeted.
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
    else { // from unretweeted --> retweeted
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [sender setTitle:@(self.tweet.retweetCount).stringValue forState:UIControlStateSelected];
        [sender setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        
        [sender setSelected:YES];
        
        // Send a POST request to the POST retweets/create endpoint
        // Call the retweet(completion:) method and pass in the tweet to be retweeted.
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (IBAction)didTapFavorite:(id)sender {
    
    // Update the local tweet model and cell UI
    if ([sender isSelected]) { // from favorited --> unfavorited
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [sender setTitle:@(self.tweet.favoriteCount).stringValue forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        
        [sender setSelected:NO];
        
        // Send a POST request to the POST favorites/create endpoint
        // Call the unfavorite(completion:) method and pass in the tweet to be unfavorited.
         [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
    }
    else { // from unfavorited --> favorited
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [sender setTitle:@(self.tweet.favoriteCount).stringValue forState:UIControlStateSelected];
        [sender setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        
        [sender setSelected:YES];
        
        // Send a POST request to the POST favorites/create endpoint
        // Call the favorite(completion:) method and pass in the tweet to be favorited.
         [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}


- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.usernameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = self.tweet.user.screenName;
    self.tweetTextLabel.text = self.tweet.text;
    
    // Set date
    // https://stackoverflow.com/questions/9769190/create-a-nsdate-from-a-string
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/yy";
    NSDate *createdAtDate = [formatter dateFromString:self.tweet.createdAtString];
    NSString *timeAgo = createdAtDate.shortTimeAgoSinceNow;
    self.timestampLabel.text = timeAgo;
    
    // Set profile image
    // https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
    self.profileView.image = nil;
    if (self.tweet.user.profilePicture != nil) {
        
        NSString *URLString = self.tweet.user.profilePicture;
        NSURL *url = [NSURL URLWithString:URLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        self.profileView.image = [UIImage imageWithData:urlData];
    }
    
    // Set value for the favorite button
    [self.favoriteButton setTitle:@(self.tweet.favoriteCount).stringValue forState:UIControlStateNormal];

    // Set value for the retweet button
    [self.retweetButton setTitle:@(self.tweet.retweetCount).stringValue forState:UIControlStateNormal];

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
