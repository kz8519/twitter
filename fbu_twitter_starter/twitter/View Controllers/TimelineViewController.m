//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, TweetCellDelegate, UITableViewDelegate, UITableViewDataSource>
- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets; // Array of tweets
@property (nonatomic, strong) UIRefreshControl *refreshControl; // Refresh control


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set data source and delegate to the view controller
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchTweets];
    
    // Implement refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [self fetchTweets];
}

- (void)fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) { // tweets is an array of Tweets, not dictionaries

            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];

    cell.tweet = tweet;
    cell.delegate = self;
    
    return cell;
}

- (void)didTweet:(Tweet *)tweet {
    
    // Add new tweet to arrayOfTweets
    [self.arrayOfTweets addObject:tweet];
    
    // Fetch all tweets (new one included)
    [self fetchTweets];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([sender isKindOfClass: [UIBarButtonItem class]]) {
        // Segue to ComposeViewController so user can compose tweets
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    else if ([sender isKindOfClass: [TweetCell class]]) {
        // Segue to DetailsViewController so user can view tweet details
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Tweet *dataToPass = self.arrayOfTweets[indexPath.row];
        DetailsViewController *detailVC = [segue destinationViewController];
        detailVC.tweet = dataToPass;
    }
    else if ([segue.identifier isEqualToString:@"profileSegue"]) {
        ProfileViewController *profileController = [segue destinationViewController];
        profileController.user = sender;
    }

}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    // Perform segue to profile view controller
    [self performSegueWithIdentifier:@"profileSegue" sender:user];

}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    // Clear out access tokens
    [[APIManager shared] logout];
}
@end
