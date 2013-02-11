//
//  QuandlKit.m
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import "QuandlKit.h"
#import "QuandlSearchResults.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

#define API_TOKEN @"HAHAHAHAHANO"

static QuandlKit *__quandlKitSingletonInstance = nil;

@interface _QuandlKit : AFHTTPClient
@end
@implementation _QuandlKit
@end


@implementation QuandlKit {
    _QuandlKit *_kit;
}

+ (QuandlKit *)quandlKit {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __quandlKitSingletonInstance = [[QuandlKit alloc] init];
    });
    return __quandlKitSingletonInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        //Do I need anything else?
        _kit = [[_QuandlKit alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.quandl.com/"]];
        [_kit setParameterEncoding:AFJSONParameterEncoding];
        [_kit registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return self;
}

- (void)dealloc {
    [_kit release];
    [super dealloc];
}

- (NSMutableDictionary *)parameters {
    return [NSMutableDictionary dictionaryWithObject:API_TOKEN forKey:@"auth_token"];
}

- (void)searchQuandl:(NSString *)searchString completionBlock:(QuandlKitOperationCompletionBlock)completionBlock {
    [self searchQuandl:searchString page:0 completionBlock:completionBlock];
}

- (void)searchQuandl:(NSString *)searchString page:(NSUInteger)page completionBlock:(QuandlKitOperationCompletionBlock)completionBlock {
    NSMutableDictionary *parameters = [self parameters];
    if (0 != page) {
        [parameters setObject:[@(page) stringValue] forKey:@"page"];
    }
    
    [_kit getPath:[NSString stringWithFormat:@"search/%@.json", searchString] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionBlock([[[QuandlSearchResults alloc] initWithProcessedJSON:responseObject] autorelease], YES, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(nil, NO, [[error copy] autorelease]);
    }];
}


- (void)buildSuperSetFromDatasets:(NSArray *)datasets completionBlock:(QuandlKitOperationCompletionBlock)completionBlock {
    //Find greatest common frequency, then use that.
    QuandlDataSetFrequency supersetFrequency = QuandlDataSetFrequencyDaily;
    for (QuandlDataSet *dataSet in datasets) {
        QuandlDataSetFrequency dataSetFrequency = supersetFrequency.frequency;
        if (dataSetFrequency == supersetFrequency) {
            continue;
        }
        
        if (dataSetFrequency > supersetFrequency) {
            
        }
        
    }
}

- (void)buildSuperSetFromDatasets:(NSArray *)datasets frequency:(QuandlDataSetFrequency)frequency completionBlock:(QuandlKitOperationCompletionBlock)completionBlock {
    //Verify that this frequency can be used
    //Spin off several requests for those data sets
    //Write results to disk
    //Build sqlite file with results (primary key = time dimension, each others are measures)
    //Insert first request returned into SQLite
    //Insert subsequent requests (pk's should be the same because of frequency checking)
    //return QuandlSuperSet / maybe QuandlLocalSuperSet    
}


@end