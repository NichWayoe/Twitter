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
#import "APIManager.h"
@interface tweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likedButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

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
    self.likeCountLabel.text = [NSString stringWithFormat:@"%i",self.tappedTweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%i",self.tappedTweet.retweetCount];
    self.profilePhotoView.layer.cornerRadius=25;
    self.profilePhotoView.layer.masksToBounds=YES;
    
}
- (IBAction)onTapLike:(id)sender {
    if (self.likedButton.isSelected)
    {
        self.tappedTweet.favoriteCount -= 1;
        self.likedButton.selected=NO;
        self.tappedTweet.isLiked= NO;
        [APIManager.shared unlike:self.tappedTweet completion:^(tweet *tweety, NSError *error)
          {
             if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
           }     else{
               NSLog(@"Successfully favorited the following Tweet: %@",self.tappedTweet.text);
            }
        }];

    }
    else
    {
        self.tappedTweet.favoriteCount += 1;
        self.likedButton.selected=YES;
        self.tappedTweet.isLiked = YES;
        [APIManager.shared like:self.tappedTweet completion:^(tweet *tweety, NSError *error)
          {
             if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
           }     else{
               NSLog(@"Successfully favorited the following Tweet: %@",self.tappedTweet.text);
            }
        }];
    }
    [self updateCell] ;
    
}
- (IBAction)onTapRetweet:(id)sender {
    if (self.retweetButton.isSelected)
    {
        self.tappedTweet.retweetCount -= 1;
        self.retweetButton.selected=NO;
        self.tappedTweet.isRetweeted = NO;
        [APIManager.shared unretweet:self.tappedTweet completion:^(tweet *tweety, NSError *error)
        {
            if(error)
            {
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
            else
            {
                NSLog(@"Successfully favorited the following Tweet: %@",self.tappedTweet.text);
            }
          }];
      }
      else
      {
          self.tappedTweet.retweetCount += 1;
          self.retweetButton.selected=YES;
          self.tappedTweet.isRetweeted = YES;
          [APIManager.shared retweet:self.tappedTweet completion:^(tweet *tweety, NSError *error)
            {
               if(error){
                   NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }     else{
                 NSLog(@"Successfully favorited the following Tweet: %@",self.tappedTweet.text);
              }
          }];
          
      }
      [self updateCell] ;
    
}
- (void) updateCell
{
    self.likeCountLabel.text = [NSString stringWithFormat:@"%i",self.tappedTweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%i",self.tappedTweet.retweetCount];
}

@end
