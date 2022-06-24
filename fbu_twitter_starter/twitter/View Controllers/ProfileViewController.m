//
//  ProfileViewController.m
//  twitter
//
//  Created by Kathy Zhong on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *bannerView;
@property (strong, nonatomic) IBOutlet UIImageView *profileView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *taglineLabel;
@property (strong, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (strong, nonatomic) IBOutlet UILabel *numFollowersLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"%@", self.user.screenName);
    self.usernameLabel.text = self.user.name;
    self.screenNameLabel.text = self.user.screenName;
    self.taglineLabel.text = self.user.tagline;
    self.numTweetsLabel.text = [self.user.numTweets stringByAppendingString:@" tweets"];
    self.numFollowingLabel.text = [self.user.numFollowing stringByAppendingString:@" following"];
    self.numFollowersLabel.text = [self.user.numFollowers stringByAppendingString:@" followers"];
    
    // Set profile and banner image
    // https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
    self.profileView.image = nil;
    if (self.user.profilePicture != nil) {
        
        NSString *URLString = self.user.profilePicture;
        NSURL *url = [NSURL URLWithString:URLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        self.profileView.image = [UIImage imageWithData:urlData];
    }
    
    self.bannerView.image = nil;
    if (self.user.bannerPicture != nil) {
        
        NSString *URLString = self.user.bannerPicture;
        NSURL *url = [NSURL URLWithString:URLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        
        self.bannerView.image = [UIImage imageWithData:urlData];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
