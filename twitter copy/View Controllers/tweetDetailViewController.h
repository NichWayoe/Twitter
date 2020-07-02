//
//  tweetDetailViewController.h
//  twitter
//
//  Created by Nicholas Wayoe on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"
NS_ASSUME_NONNULL_BEGIN

@interface tweetDetailViewController : UIViewController
@property (strong,nonatomic) tweet *tappedTweet;

@end

NS_ASSUME_NONNULL_END
