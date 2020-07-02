//
//  ComposeViewController.h
//  twitter
//
//  Created by Nicholas Wayoe on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tweet.h"
NS_ASSUME_NONNULL_BEGIN


@protocol ComposeViewControllerDelegate
- (void)didTweet:(tweet *)tweet;
@end

@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
