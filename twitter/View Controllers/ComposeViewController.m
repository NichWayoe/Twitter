//
//  ComposeViewController.m
//  twitter
//
//  Created by Nicholas Wayoe on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetView;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UILabel *characterLeft;

@end

@implementation ComposeViewController

- (void)viewDidLoad
{
    self.characterLeft.text =  [NSString stringWithFormat:@"%i",270];
    self.tweetButton.enabled = NO;
    self.tweetView.text =@"";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetView.delegate = self;
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

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.tweetView.text.length <= 270)
        self.tweetButton.enabled = YES;
    else
          self.tweetButton.enabled = NO;
    int charactersLeftt = 270 - self.tweetView.text.length;
    self.characterLeft.text =  [NSString stringWithFormat:@"%i",charactersLeftt];
    
}
@end
 

