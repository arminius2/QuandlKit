//
//  QuandlKitUnitTests.m
//  QuandlKitUnitTests
//
//  Created by Alex C. Schaefer on 2/10/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import "QuandlKitUnitTests.h"
#import "QuandlKit.h"
#import "QuandlSearchResults.h"

#define BUILD_SEMAPHORE dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
#define SIGNAL_SEMAPHORE dispatch_semaphore_signal(semaphore);
#define WAIT_UNTILSEMAPHORE_FIRES     while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)) { [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]]; }
#define TEARDOWN_SEMAPHORE dispatch_release(semaphore); semaphore = NULL;

@implementation QuandlKitUnitTests

- (void)testBasicSearch {
    QuandlKit *kit = [QuandlKit quandlKit];
    BUILD_SEMAPHORE;
    [kit searchQuandl:@"test" page:0 completionBlock:^(QuandlKitResult *result, BOOL completedSuccessfully, NSError *error) {
        STAssertTrue(completedSuccessfully && [[(QuandlSearchResults *)result searchResults] count] > 0, @"Search Request did not complete successfully.");
        SIGNAL_SEMAPHORE;
    }];
        
    WAIT_UNTILSEMAPHORE_FIRES;
    TEARDOWN_SEMAPHORE;
}

- (void)testMultipageSearch {
    QuandlKit *kit = [QuandlKit quandlKit];
    NSUInteger totalResults = 0;
    NSUInteger totalResultsReceived = 0;
    NSString *searchQuery = @"test";
    __block QuandlSearchResults *results = nil;
    __block BOOL lastSearchResultWasSuccessful = YES;
    
    BUILD_SEMAPHORE;
    [kit searchQuandl:searchQuery page:0 completionBlock:^(QuandlKitResult *result, BOOL completedSuccessfully, NSError *error) {
        STAssertTrue(completedSuccessfully && [[(QuandlSearchResults *)result searchResults] count] > 0, @"Search Request did not complete successfully.");
        results = (QuandlSearchResults *)[result retain];
        lastSearchResultWasSuccessful = completedSuccessfully;
        SIGNAL_SEMAPHORE;
    }];
    
    WAIT_UNTILSEMAPHORE_FIRES;
    TEARDOWN_SEMAPHORE;
    
    if (!lastSearchResultWasSuccessful) {
        return;
    }
    
    totalResults = [results totalResultCount];
    totalResultsReceived = [[results searchResults] count];
    int currentPage = 1;
    while(totalResultsReceived < totalResults && lastSearchResultWasSuccessful) {
        BUILD_SEMAPHORE;
        [kit searchQuandl:searchQuery page:currentPage completionBlock:^(QuandlKitResult *result, BOOL completedSuccessfully, NSError *error) {
            STAssertTrue(completedSuccessfully && [[(QuandlSearchResults *)result searchResults] count] > 0, @"Search Request did not complete successfully.");
            results = (QuandlSearchResults *)[result retain];
            lastSearchResultWasSuccessful = completedSuccessfully;
            SIGNAL_SEMAPHORE;
        }];
        
        WAIT_UNTILSEMAPHORE_FIRES;
        TEARDOWN_SEMAPHORE;
        
        totalResultsReceived += [[results searchResults] count];
        currentPage++;
    }
    STAssertEquals(totalResults, totalResultsReceived, @"Did not receive correct number of results in multipage search query.");
}

@end
