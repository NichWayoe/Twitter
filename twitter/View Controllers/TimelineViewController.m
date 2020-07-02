//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"
#import "ComposeViewController.h"
#import "TweetCell.h"
#import "tweet.h"
#import "User.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "tweetDetailViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *tweetsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getTweets];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)onTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}

- (void) getTweets
{
    [APIManager.shared getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            self.tweetsArray = tweets;
            [self.refreshControl endRefreshing];
            }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    
    cell.currentTweet = self.tweetsArray[indexPath.row];
    cell.nameLabel.text= cell.currentTweet.user.name;
    cell.userNameLabel.text =cell.currentTweet.user.screenName;
    cell.tweetContentlabel.text = cell.currentTweet.text;
    cell.retweetLabel.text = [NSString stringWithFormat:@"%i",cell.currentTweet.retweetCount];
    cell.likesLabel.text = [NSString stringWithFormat:@"%i",cell.currentTweet.favoriteCount];
    cell.profilePhotoView.layer.cornerRadius=25;
    cell.profilePhotoView.layer.masksToBounds=YES;
    cell.retweetButton.selected=cell.currentTweet.isRetweeted;
    cell.likeButton.selected=cell.currentTweet.isLiked;
    [cell.profilePhotoView setImageWithURL:cell.currentTweet.user.profilePhotoURL];
    cell.timeLabel.text = cell.currentTweet.createdAtString;
    cell.commentCountLabel.text =[NSString stringWithFormat:@"%i",cell.currentTweet.commentsCount];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetsArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier  isEqual: @"composeTweet"])
    {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    else if([segue.identifier  isEqual: @"tweetDetails"])
    {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        tweet *currentTweet = self.tweetsArray[indexPath.row];
        tweetDetailViewController *tweetDetailViewControllera =[segue destinationViewController];
        tweetDetailViewControllera.tappedTweet= currentTweet;
    }
}

- (void)didTweet:(tweet *)tweet
{
    [self.tweetsArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}
@end
