//
//  tweet.m
//  twitter
//
//  Created by Nicholas Wayoe on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "tweet.h"
#import "User.h"
@implementation tweet
-(instancetype) initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self){
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet !=nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            dictionary = originalTweet;
    }
    self.idStr = dictionary[@"id_str"];
    self.text = dictionary[@"text"];
    self.favoriteCount = [dictionary[@"favorite_count"] intValue];
    self.favorited = [dictionary[@"favorited"] boolValue];
    self.retweetCount = [dictionary[@"retweet_count"] intValue];
    self.retweeted = [dictionary[@"retweeted"] boolValue];
    NSDictionary *user = dictionary[@"user"];
    self.user = [[User alloc] initWithDictionary:user];
    
    // Format createdAt date string
    NSString *createdAtOriginalString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:createdAtOriginalString];
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    self.createdAtString = [formatter stringFromDate:date];
        
}
    return self;
}
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        tweet *Tweet = [[tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:Tweet];
        
    }
    return tweets;
}

@end