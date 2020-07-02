//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "tweet.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSMutableArray *tweets, NSError *error))completion;
- (void)postStatusWithText:(NSString *)text completion:(void (^)(tweet *, NSError *))block;
- (void)like:(tweet *)tweety completion:(void (^)(tweet *, NSError *))completion;
- (void)unlike:(tweet *)tweety completion:(void (^)(tweet *, NSError *))completion;
- (void)retweet:(tweet *)tweety completion:(void (^)(tweet *, NSError *))completion;
- (void)unretweet:(tweet *)tweety completion:(void (^)(tweet *, NSError *))completion;
@end
