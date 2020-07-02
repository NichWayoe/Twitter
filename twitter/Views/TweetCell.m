//
//  TweetCell.m
//  twitter
//
//  Created by Nicholas Wayoe on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "tweet.h"

@implementation TweetCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (IBAction)onRetweeted:(id)sender
{
    if (self.retweetButton.isSelected)
    {
        self.currentTweet.retweetCount -= 1;
        self.retweetButton.selected=NO;
        self.currentTweet.isRetweeted = NO;
        [APIManager.shared unretweet:self.currentTweet completion:^(tweet *tweety, NSError *error)
        {
            if(error)
            {
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
            else
            {
                NSLog(@"Successfully favorited the following Tweet: %@",self.currentTweet.text);
            }
          }];
      }
      else
      {
          self.currentTweet.retweetCount += 1;
          self.retweetButton.selected=YES;
          self.currentTweet.isRetweeted = YES;
          [APIManager.shared retweet:self.currentTweet completion:^(tweet *tweety, NSError *error)
            {
               if(error){
                   NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }     else{
                 NSLog(@"Successfully favorited the following Tweet: %@",self.currentTweet.text);
              }
          }];
          
      }
      [self updateCell] ;
}

- (IBAction)onLiked:(id)sender {
    if (self.likeButton.isSelected)
    {
        self.currentTweet.favoriteCount -= 1;
        self.likeButton.selected=NO;
        self.currentTweet.isLiked= NO;
        [APIManager.shared unlike:self.currentTweet completion:^(tweet *tweety, NSError *error)
          {
             if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
           }     else{
               NSLog(@"Successfully favorited the following Tweet: %@",self.currentTweet.text);
            }
        }];

    }
    else
    {
        self.currentTweet.favoriteCount += 1;
        self.likeButton.selected=YES;
        self.currentTweet.isLiked = YES;
        [APIManager.shared like:self.currentTweet completion:^(tweet *tweety, NSError *error)
          {
             if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
           }     else{
               NSLog(@"Successfully favorited the following Tweet: %@",self.currentTweet.text);
            }
        }];
    }
    [self updateCell] ;
}

- (void) updateCell
{
    self.likesLabel.text = [NSString stringWithFormat:@"%i",self.currentTweet.favoriteCount];
    self.retweetLabel.text = [NSString stringWithFormat:@"%i",self.currentTweet.retweetCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
@end
