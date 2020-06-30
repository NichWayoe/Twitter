//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "tweet.h"
#import "User.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray *Tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self getTweets];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
   }

-(void) getTweets{
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            self.Tweets = tweets;
            [self.refreshControl endRefreshing];
            }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
        [self.tableView reloadData];
       
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
        tweet *tweety = self.Tweets[indexPath.row];
    cell.namelabel.text=tweety.user.name;
    cell.userNameLabel.text = tweety.user.ScreenName;
    NSLog(@"%@",tweety.user.ScreenName);
    cell.tweetContentlabel.text =tweety.text;
    cell.retweetLabel.text = [NSString stringWithFormat:@"%i",tweety.retweetCount];
    cell.likesLabel.text = [NSString stringWithFormat:@"%i",tweety.favoriteCount];
    cell.timeLabel.text = tweety.createdAtString;
        NSLog(@"rrr");
        return cell;
    }
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Tweets.count;
}

@end
