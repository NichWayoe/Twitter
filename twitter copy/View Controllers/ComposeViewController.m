//
//  ComposeViewController.m
//  twitter
//
//  Created by Nicholas Wayoe on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetView;

@end

@implementation ComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onTapTweetButton:(id)sender
{
    NSString *tweetContent = self.tweetView.text;
    [APIManager.shared postStatusWithText:tweetContent completion:^(tweet *newTweet, NSError *error) {
    if (newTweet)
    {
        [self.delegate didTweet:newTweet];
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else
    {
        NSLog(@"😫😫😫 Error for composing tweet %@", error.localizedDescription);
    }
        }];
}
    
- (IBAction)onTapClose:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
