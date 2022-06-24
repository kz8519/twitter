//
//  ComposeViewController.m
//  twitter
//
//  Created by Kathy Zhong on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *profileView;
- (IBAction)didTapClose:(id)sender;
- (IBAction)didTapTweet:(id)sender;

@end

@implementation ComposeViewController

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

/*
- (void) composeTweet(completion:) {
    [[APIManager shared]postStatusWithText:@"This is my tweet 😀" completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
}
 */

- (IBAction)didTapTweet:(id)sender { //equivalent to didTapPost in the instructions
    
    [[APIManager shared]postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
        // Dismiss ComposeViewController
        [self didTapClose:(sender)];
    }];
    
//    [self composeTweet];
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
