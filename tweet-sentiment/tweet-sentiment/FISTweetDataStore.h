//
//  FISTweetDataStore.h
//  tweet-sentiment
//
//  Created by Yoseob Lee on 7/9/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FISTweetDataStore : NSObject
@property (nonatomic) CGFloat count;
@property (nonatomic) CGFloat totalPolarity;

+(instancetype)sharedDataStore;

-(void)fetchAllTweetsWithCompletion:(void (^)(BOOL))block;
-(void)getSentimentPolarity:(NSDictionary *)tweetDict withCompletionHandler:(void (^)(CGFloat))completionBlock;

@end
