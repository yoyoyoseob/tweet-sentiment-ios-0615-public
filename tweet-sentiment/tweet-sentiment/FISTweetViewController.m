//
//  FISTweetViewController.m
//  tweet-sentiment
//
//  Created by Yoseob Lee on 7/9/15.
//  Copyright (c) 2015 Yoseob Lee. All rights reserved.
//

#import "FISTweetViewController.h"
#import "FISTweetDataStore.h"
#import <UIKit/UIKit.h>

@interface FISTweetViewController ()
@property (nonatomic, strong) FISTweetDataStore *dataStore;
@property (weak, nonatomic) IBOutlet UILabel *polarityLabel;

@end

@implementation FISTweetViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [FISTweetDataStore sharedDataStore];
    
    [[FISTweetDataStore sharedDataStore]fetchAllTweetsWithCompletion:^(BOOL success) {
        CGFloat total = self.dataStore.totalPolarity;
        CGFloat count = self.dataStore.count;
        
        CGFloat average = total / count;
        NSLog(@"%f", average);
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.polarityLabel.text = [NSString stringWithFormat:@"%f", average];
        }];
    }];
}

@end
