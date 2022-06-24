//
//  ReplyViewController.m
//  twitter
//
//  Created by Kathy Zhong on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "APIManager.h"

@interface ReplyViewController ()
- (IBAction)didTapClose:(id)sender;
- (IBAction)didTapReply:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *profileView;



@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set profile image
    // TODO: https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
    self.profileView.image = nil;

    [[APIManager shared] getProfilePicture:^(NSString *URLString, NSError *error) {
        if (URLString) {
            NSLog(@"😎😎😎 Successfully loaded profile picture");
            NSURL *url = [NSURL URLWithString:URLString];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            
            self.profileView.image = [UIImage imageWithData:urlData];
        } else {
            NSLog(@"😫😫😫 Error getting profile picture: %@", error.localizedDescription);
        }
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapReply:(id)sender {
//    NSLog(@"%@", self.user.screenName);
    NSString *atUsername = [NSString stringWithFormat:@"%@ ", self.tweet.user.screenName];
    NSString *fullText = [atUsername stringByAppendingString:self.textView.text];
    
    [[APIManager shared]postReplyWithText:self.tweet :fullText completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Reply: %@", error.localizedDescription);
        }
        else{
            [self.delegate didReply:tweet];
            NSLog(@"Compose Reply Success!");
        }
        // Dismiss ComposeViewController
        [self didTapClose:(sender)];
    }];
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
