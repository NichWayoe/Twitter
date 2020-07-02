//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "tweet.h"

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey =
@"NHYEgJ9EhWNiuzIY6Jegxe17n";
static NSString * const consumerSecret =@"uCDQgYivwUJcQyiJdo5qB7gVtbR8CHMIo8bElUFAQgiGfZZL7R";


@interface APIManager()


@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

- (void)getHomeTimelineWithCompletion:(void(^)(NSMutableArray *tweets, NSError *error))completion
{
   [self GET:@"1.1/statuses/home_timeline.json"
   parameters:nil progress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
       NSMutableArray *tweets  = [tweet tweetsWithArray:tweetDictionaries];
       completion(tweets, nil);
       
   }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // There was a problem
       completion(nil, error);
   }];
}

- (void)postStatusWithText:(NSString *)text completion:(void (^)(tweet *, NSError *))block{
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        tweet *newTweet = [[tweet alloc]initWithDictionary:tweetDictionary];
        if(newTweet)
            block(newTweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}

- (void)like:(tweet *)currentTweet completion:(void (^)(tweet *, NSError *))completion{

    NSString *urlString = @"1.1/favorites/create.json";
    NSDictionary *parameters = @{@"id": currentTweet.tweetID};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        tweet *currentTweet = [[tweet alloc]initWithDictionary:tweetDictionary];
        if(currentTweet)
            completion(currentTweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)unlike:(tweet *)currentTweet completion:(void (^)(tweet *, NSError *))completion{

    NSString *urlString = @"1.1/favorites/destroy.json";
    NSDictionary *parameters = @{@"id": currentTweet.tweetID};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        tweet *currentTweet = [[tweet alloc]initWithDictionary:tweetDictionary];
        if(currentTweet)
            completion(currentTweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)retweet:(tweet *)currentTweet completion:(void (^)(tweet *, NSError *))completion{

    NSString *urlString = @"1.1/statuses/retweet.json";
    NSDictionary *parameters = @{@"id": currentTweet.tweetID};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        tweet *currentTweet = [[tweet alloc]initWithDictionary:tweetDictionary];
        if(currentTweet)
            completion(currentTweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)unretweet:(tweet *)currentTweet completion:(void (^)(tweet *, NSError *))completion{

    NSString *urlString = @"1.1/statuses/unretweet.json";
    NSDictionary *parameters = @{@"id": currentTweet.tweetID};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        tweet *currentTweet = [[tweet alloc]initWithDictionary:tweetDictionary];
        if(currentTweet)
            completion(currentTweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}
@end

