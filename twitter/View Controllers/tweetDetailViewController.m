//
//  tweetDetailViewController.m
//  twitter
//
//  Created by Nicholas Wayoe on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "tweetDetailViewController.h"
#import "tweet.h"
#import "UIImageView+AFNetworking.h"
@interface tweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likedButton;

@end

@implementation tweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetContentLabel.text = self.tappedTweet.text;
    self.nameLabel.text = self.tappedTweet.user.name;
    self.usernameLabel.text = self.tappedTweet.user.screenName;
    self.timeLabel.text = self.tappedTweet.createdAtString;
    [self.profilePhotoView setImageWithURL:self.tappedTweet.user.profilePhotoURL];
    self.retweetButton.selected = self.tappedTweet.isRetweeted;
    self.likedButton.selected = self.tappedTweet.isLiked;
}




@end
