//
//  FISTweetAPIClient.h
//  tweet-sentiment
//
//  Created by Yoseob Lee on 7/9/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISTweetAPIClient : NSObject
@property (nonatomic, strong) NSArray *twitterFeed;

+(void)getAllTweetsFromUserWithCompletionHandler:(void (^)(NSArray *, NSError *))completionBlock;

@end
