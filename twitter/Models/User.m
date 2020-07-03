//
//  User.m
//  twitter
//
//  Created by Nicholas Wayoe on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.name = dictionary[@"name"];
        self.screenName = [@"@" stringByAppendingString: dictionary[@"screen_name"]];
        NSString *url = [dictionary[@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        NSLog(@"%@",url);
        self.profilePhotoURL = [NSURL URLWithString:url];
    }
    return self;
}
@end
