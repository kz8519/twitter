//
//  ComposeViewController.m
//  twitter
//
//  Created by Kathy Zhong on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>

@interface ComposeViewController () <UITextViewDelegate> // Implementing character count
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIImageView *profileView;
@property (strong, nonatomic) IBOutlet UILabel *charCountLabel;
- (IBAction)didTapClose:(id)sender;
- (IBAction)didTapTweet:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Implementing character count
    self.textView.delegate = self;
    
    self.textView.placeholder = @"What's happening?";
    
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    // Check the proposed new text character count and then allow/disallow the new text
    
    // Set the max character limit
    int characterLimit = 280;

    // Construct what the new text would be if we allowed the user's latest edit
    // range has length 0 if referring to current insertion point (1 for each character we wish to delete)
    NSString *newText = [self.textView.text stringByReplacingCharactersInRange:range withString:text];
    
//    NSLog(@"%@", text);
//    NSLog(@"%@", newText);
//    NSLog(@"%@", range);

    // Update character count label
    if (newText.length <= characterLimit) {
        self.charCountLabel.text = [NSString stringWithFormat:@"%lu", newText.length];
    }
    else {
        self.charCountLabel.text = [NSString stringWithFormat:@"%d", characterLimit];
        
        // Create UIAlertController
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Character Limit Reached"
                                                     message:@"You have reached the 280 character limit."
                                                     preferredStyle:(UIAlertControllerStyleAlert)];
        // Create "OK" action + button
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay"
                                                     style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
        // add the "OK" action to the alertController
        [alert addAction:okAction];
        
        // Show UIAlertController
        [self presentViewController:alert animated:YES completion:^{
        }];
    }

    // Should the new text should be allowed? True/False
    return newText.length <= characterLimit;

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
