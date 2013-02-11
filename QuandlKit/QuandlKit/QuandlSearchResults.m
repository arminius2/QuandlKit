//
//  QuandlSearchResult.m
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import "QuandlSearchResults.h"

#define RESULTS_PER_PAGE 20

@interface QuandlSearchResults ()

@end

@implementation QuandlSearchResults {
    NSArray *_searchResults;
}

- (void)dealloc
{
    [_searchResults release];
    [super dealloc];
}

- (NSArray *)searchResults {
    if (nil != _searchResults) {
        return _searchResults;
    }
    NSMutableArray *processedSearchResults = [NSMutableArray new];
    NSDictionary *processedJson = (NSDictionary *)[self processedJSON];
    NSArray *searchResults = [[processedJson objectForKey:@"response"] objectForKey:@"datasets"];
    for (NSDictionary *result in searchResults) {
        QuandlDataSet *dataset = [[QuandlDataSet alloc] initWithProcessedJSON:result];
        [processedSearchResults addObject:dataset];
        [dataset release];
    }
    _searchResults = (NSArray *)processedSearchResults;
     return _searchResults;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
    return [self.searchResults countByEnumeratingWithState:state objects:stackbuf count:len];
}

- (NSString *)description {
    return [self.searchResults description];
}

- (NSUInteger)startIndex {
    return [[[(NSDictionary *)[self processedJSON] objectForKey:@"response"] objectForKey:@"start"] unsignedIntegerValue];
}

- (NSUInteger)totalResultCount {
    return [[[(NSDictionary *)[self processedJSON] objectForKey:@"response"] objectForKey:@"numFound"] unsignedIntegerValue];
}

- (NSUInteger)page {
    NSUInteger start = [self startIndex];
    if (0 == start) {
        return 0;
    }
    return start / RESULTS_PER_PAGE;
}

- (NSRange)range {
    return NSMakeRange([self startIndex], RESULTS_PER_PAGE);
}

- (float)maxScore {
    return [[[(NSDictionary *)[self processedJSON] objectForKey:@"response"] objectForKey:@"maxScore"] floatValue];
}

@end
