//
//  FISTweetDataStore.m
//  tweet-sentiment
//
//  Created by Yoseob Lee on 7/9/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "FISTweetDataStore.h"
#import <STTwitter/STTwitter.h>

@implementation FISTweetDataStore

+(instancetype)sharedDataStore {
    static FISTweetDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISTweetDataStore alloc] init];
    });
    return _sharedDataStore;
}

-(void)fetchAllTweetsWithCompletion:(void (^)(BOOL))block
{
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"o4BLC00wAcG9DmyFKb1cxyYeb" consumerSecret:@"FT3iYuPqN03me72t2ZBGoUYED4gy5LuRUi6H5YORNZ5ON0FvrE"];
    
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        
        [twitter getSearchTweetsWithQuery:@"FlatironSchool" successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            // For loop that takes in array of dictionaries and returns each Tweet's "text" value
            //NSLog(@"%lu", statuses.count);
            for (NSDictionary *tweetDictionary in statuses)
            {
                [self getSentimentPolarity:tweetDictionary withCompletionHandler:^(CGFloat polarity) {
                    // WORK WITH THE NSINTEGER THAT IS RETURNED TO GET AVERAGE POLARITY
                    
                    self.totalPolarity = self.totalPolarity + polarity;
                    
                    if (self.count == 15.0)
                    {
                        block(YES); // This needs to happen if a condition is met -- either reaching total count or live update of label
                    }
                    
                }];
            }
            
        } errorBlock:^(NSError *error) {
            NSLog(@"Error: %@", error.debugDescription);
            
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error.debugDescription);
    }];
    
}

-(void)getSentimentPolarity:(NSDictionary *)tweetDict withCompletionHandler:(void (^)(CGFloat))completionBlock
{
    NSString *unescapedString = tweetDict[@"text"];
    NSString *escapedString = [unescapedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
//    NSLog(@"%@", escapedString);
//    http://www.sentiment140.com/api/classify?text=
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.sentiment140.com/api/classify?text=%@", escapedString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        CGFloat polarity = [responseDictionary[@"results"][@"polarity"] floatValue];
        NSLog(@"%f", polarity);
        self.count ++;
        
        completionBlock(polarity);
    }];
    [task resume];
}

@end
