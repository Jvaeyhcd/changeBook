//
//  NSDate+Polesapp.h
//  govlan
//
//  Created by Jvaeyhcd on 2016/11/25.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

#import <Foundation/Foundation.h>

@interface NSDate (Polesapp)

+ (void)initializeStatics;

+ (NSCalendar *)sharedCalendar;
+ (NSDateFormatter *)sharedDateFormatter;

- (NSInteger)monthsAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSInteger)secondsAgo;
- (NSInteger)minutesAgo;
- (NSInteger)hoursAgo;

- (NSString *)stringTimesAgo;
+ (NSString *)stringTimesAgoFromTimeInterval:(NSTimeInterval)time;
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond;

@end
