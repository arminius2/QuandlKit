//
//  QuandlKitResult.h
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuandlKitResult : NSObject <NSCopying>
- (id)initWithData:(NSData *)data;
- (id)initWithProcessedJSON:(NSObject *)containerObject;
@property (nonatomic, readonly) NSObject *processedJSON;
@end
