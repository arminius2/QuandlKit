//
//  QuandlKit.h
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuandlKitResult.h"

typedef void(^QuandlKitOperationCompletionBlock)(QuandlKitResult *result, BOOL completedSuccessfully, NSError *error);

@interface QuandlKit : NSObject
+ (QuandlKit *)quandlKit;
- (void)searchQuandl:(NSString *)searchString completionBlock:(QuandlKitOperationCompletionBlock)completionBlock;
- (void)searchQuandl:(NSString *)searchString page:(NSUInteger)page completionBlock:(QuandlKitOperationCompletionBlock)completionBlock;

- (void)buildSuperSetFromDatasets:(NSArray *)datasets frequency:(QuandlDataSetFrequency)frequency completionBlock:(QuandlKitOperationCompletionBlock)completionBlock;
- (void)buildSuperSetFromDatasets:(NSArray *)datasets completionBlock:(QuandlKitOperationCompletionBlock)completionBlock;
@end