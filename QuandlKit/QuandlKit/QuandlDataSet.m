//
//  QuandlDataSet.m
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import "QuandlDataSet.h"

@implementation QuandlDataSet
- (id)initWithProcessedJSON:(NSObject *)containerObject {
    self = [super initWithProcessedJSON:containerObject];
    if (nil != self) {
        /*
         NSString *_name;
         NSString *_quandlCode;
         NSArray *_columnNames;
         NSDate *_dateCreated;
         NSDate *_fromDate;
         NSDate *_toDate;
         QuandlDataSetFrequency _availableFrequency;
         */
        _name = [(NSDictionary *)containerObject objectForKey:@"name"];
        _quandlCode = [(NSDictionary *)containerObject objectForKey:@"code"];
        _columnNames = [(NSDictionary *)containerObject objectForKey:@"column_names"];
        //NSDateFormatter should be used here to convert the following
        _dateCreated = [(NSDictionary *)containerObject objectForKey:@"created_at"];
        _fromDate = [(NSDictionary *)containerObject objectForKey:@"from_date"];
        _toDate = [(NSDictionary *)containerObject objectForKey:@"to_date"];
        
        //use frequency key to figure this part out.
        _availableFrequency = 0;
    }
    return self;
}
@end
 