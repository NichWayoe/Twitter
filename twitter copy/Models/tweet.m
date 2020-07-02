//
//  tweet.m
//  twitter
//
//  Created by Nicholas Wayoe on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "tweet.h"
#import "User.h"
#import "DateTools.h"
@implementation tweet

- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self){
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet !=nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            dictionary = originalTweet;
    }
        self.tweetID = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.isLiked = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.isRetweeted = [dictionary[@"retweeted"] boolValue];
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        self.createdAtString = date.shortTimeAgoSinceNow;
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries)
    {
        tweet *Tweet = [[tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:Tweet];
    }
    return tweets;
}
@end
