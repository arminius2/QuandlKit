//
//  QuandlKitResult.m
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import "QuandlKitResult.h"
#import "QuandlKit.h"

@implementation QuandlKitResult {
    NSData *_downloadedResults;
    NSObject *_processedJSON;
}

- (id)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        _downloadedResults = [data retain];
    }
    return self;
}

- (id)initWithProcessedJSON:(NSObject *)containerObject {
    self = [super init];
    if (self) {
        _processedJSON = [containerObject retain];
    }
    return self;
}

- (void)dealloc {
    [_downloadedResults release];
    [_processedJSON release];
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone {
    if (nil != _processedJSON) {
        return [[QuandlKitResult alloc] initWithProcessedJSON:_processedJSON];
    } else if (nil != _downloadedResults) {
        return [[QuandlKitResult alloc] initWithData:_downloadedResults];
    }
    return nil;
}

- (NSObject *)processedJSON {
    if (nil != _processedJSON) {
        return _processedJSON;
    }
    
    _processedJSON = [[NSJSONSerialization JSONObjectWithData:_downloadedResults options:0 error:nil] retain];
    return _processedJSON;
}

@end
