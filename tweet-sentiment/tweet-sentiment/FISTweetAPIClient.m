//
//  FISTweetAPIClient.m
//  tweet-sentiment
//
//  Created by Yoseob Lee on 7/9/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "FISTweetAPIClient.h"
#import <STTwitter/STTwitter.h>

@interface FISTweetAPIClient ()


@end

@implementation FISTweetAPIClient

+(void)getAllTweetsFromUserWithCompletionHandler:(void (^)(NSArray *, NSError *))completionBlock
{
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"zfkFrXsTV6teGOZtMwHx09lwI"
                                                            consumerSecret:@"VO3NYpNoXpP6fKdOztXeCrCDB8iS9yySFdBneVEqv7uuxuJk3n"];
    
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID)
     {
         
         
         [twitter getSearchTweetsWithQuery:@"FlatironSchool" successBlock:^(NSDictionary *searchMetadata, NSArray *statuses)
          {
              
          }
                                errorBlock:^(NSError *error) {
                                    NSLog(@"Error: %@", error.debugDescription);
                                }];
         
     } errorBlock:^(NSError *error) {
         NSLog(@"Error: %@", error.debugDescription);
     }];
}

@end
