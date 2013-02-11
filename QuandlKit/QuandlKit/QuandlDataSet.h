//
//  QuandlDataSet.h
//  QuandlKit
//
//  Created by Alex C. Schaefer on 2/4/13.
//  Copyright (c) 2013 AlexRocks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuandlKitResult.h"

typedef enum {
    QuandlDataSetFrequencyUnknown = 1 << 0,
    QuandlDataSetFrequencyDaily = 1 << 1,
    QuandlDataSetFrequencyWeekly = 1 << 2,
    QuandlDataSetFrequencyQuarterly = 1 << 3,
    QuandlDataSetFrequencyAnnual = 1 << 4
} QuandlDataSetFrequency;

@interface QuandlDataSet : QuandlKitResult {
    NSString *_name;
    NSString *_quandlCode;
    NSArray *_columnNames;
    NSDate *_dateCreated;
    NSDate *_fromDate;
    NSDate *_toDate;
    QuandlDataSetFrequency _availableFrequency;
}
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *quandlCode;
@property (nonatomic, readonly) NSArray *columnNames;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, readonly) NSDate *fromDate;
@property (nonatomic, readonly) NSDate *toDate;
@property (nonatomic, readonly) QuandlDataSetFrequency availableFrequency;
@end
