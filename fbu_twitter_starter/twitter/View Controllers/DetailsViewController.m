//
//  DetailsViewController.m
//  twitter
//
//  Created by Kathy Zhong on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
#import "APIManager.h"
#import "ReplyViewController.h"


@interface DetailsViewController () <ReplyViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *profileView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screennameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UIButton *replyButton;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.usernameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = self.tweet.user.screenName;
    self.tweetTextLabel.text = self.tweet.text;
    
    // Set date
    self.timestampLabel.text = self.tweet.createdAtString;
    
    // Set profile image
    self.profileView.image = nil;
    if (self.tweet.user.profilePicture != nil) {
        
        NSString *URLString = self.tweet.user.profilePicture;
        NSURL *url = [NSURL URLWithString:URLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        self.profileView.image = [UIImage imageWithData:urlData];
    }
    
    // Set value for the favorite button
    [self.favoriteButton setTitle:@(self.tweet.favoriteCount).stringValue forState:self.favoriteButton.state];
    if (self.tweet.favorited) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:self.favoriteButton.state];
    }
    else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favor-icon"] forState:self.favoriteButton.state];
    }

    // Set value for the retweet button
    [self.retweetButton setTitle:@(self.tweet.retweetCount).stringValue forState:self.retweetButton.state];
    if (self.tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:self.retweetButton.state];
    }
    else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:self.retweetButton.state];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([sender isKindOfClass: [UIButton class]]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ReplyViewController *replyController = (ReplyViewController*)navigationController.topViewController;
        replyController.delegate = self;
        replyController.tweet = self.tweet;
    }
}


- (void) didReply: (Tweet *)tweet {
    [self viewDidLoad];
}

- (IBAction)didTapFavorite:(id)sender {
    
    // Update the local tweet model and cell UI
    if (self.tweet.favorited) { // from favorited --> unfavorited
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
        [sender setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
        
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

- (IBAction)didTapRetweet:(id)sender {
    // Update the local tweet model and cell UI
    if (self.tweet.retweeted) { // from retweeted --> unretweeted
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
        [sender setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
        
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

@end
