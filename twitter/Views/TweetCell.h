//
//  TweetCell.h
//  twitter
//
//  Created by Nicholas Wayoe on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"

NS_ASSUME_NONNULL_BEGIN


@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (nonatomic, strong) tweet* tweety;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentlabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

NS_ASSUME_NONNULL_END
