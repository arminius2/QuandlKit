//
//  QuandlSearchResult.h
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuandlKitResult.h"

@interface QuandlSearchResults : QuandlKitResult <NSFastEnumeration>
@property (nonatomic, readonly) NSArray *searchResults;
@property (nonatomic, readonly) NSUInteger page;
@property (nonatomic, readonly) NSUInteger totalResultCount;
@property (nonatomic, readonly) NSRange range;
@property (nonatomic, readonly) float maxScore;
@end
