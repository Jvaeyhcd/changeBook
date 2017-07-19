//
//  NSDate+Polesapp.m
//  govlan
//
//  Created by Jvaeyhcd on 2016/11/25.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "NSDate+Polesapp.h"

static NSCalendar *_calendar = nil;
static NSDateFormatter *_displayFormatter = nil;

@implementation NSDate (Polesapp)

+ (void)initializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if (_calendar == nil) {
#if __has_feature(objc_arc)
                _calendar = [NSCalendar currentCalendar];
#else
                _calendar = [[NSCalendar currentCalendar] retain];
#endif
                [_calendar setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
            }
            if (_displayFormatter == nil) {
                _displayFormatter = [[NSDateFormatter alloc] init];
                [_displayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
            }
        }
    });
}

+ (NSCalendar *)sharedCalendar {
    [self initializeStatics];
    return _calendar;
}

+ (NSDateFormatter *)sharedDateFormatter {
    [self initializeStatics];
    return _displayFormatter;
}

- (NSInteger)monthsAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components month];
}

- (NSUInteger)daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[self class] sharedDateFormatter];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSInteger)secondsAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitSecond)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components second];
}

- (NSInteger)minutesAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitMinute)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components minute];
}

- (NSInteger)hoursAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components hour];
}

- (NSString *)stringTimesAgo
{
    if ([self compare:[NSDate date]] == NSOrderedDescending) {
        return @"刚刚";
    }
    
    NSString *text = nil;
    
    NSInteger agoCount = [self monthsAgo];
    if (agoCount > 0) {
        text = [NSString stringWithFormat:@"%ld个月前", (long)agoCount];
    }else{
        agoCount = [self daysAgoAgainstMidnight];
        if (agoCount > 0) {
            text = [NSString stringWithFormat:@"%ld天前", (long)agoCount];
        }else{
            agoCount = [self hoursAgo];
            if (agoCount > 0) {
                text = [NSString stringWithFormat:@"%ld小时前", (long)agoCount];
            }else{
                agoCount = [self minutesAgo];
                if (agoCount > 0) {
                    text = [NSString stringWithFormat:@"%ld分钟前", (long)agoCount];
                }else{
                    agoCount = [self secondsAgo];
                    if (agoCount > 15) {
                        text = [NSString stringWithFormat:@"%ld秒前", (long)agoCount];
                    }else{
                        text = @"刚刚";
                    }
                }
            }
        }
    }
    return text;
}

+ (NSString *)stringTimesAgoFromTimeInterval:(NSTimeInterval)time {
    //    计算现在距1970年多少秒
    NSDate *date = [NSDate date];
    
//    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
//    NSDate *dateNow = [date dateByAddingTimeInterval: [timeZone secondsFromGMTForDate:date]];
    
    NSTimeInterval currentTime= [date timeIntervalSince1970];
    
    //    计算现在的时间和发布消息的时间时间差
    double timeDiffence = currentTime - time;
    
    //    根据秒数的时间差的不同，返回不同的日期格式
    if (timeDiffence < 10) {
        return @"刚刚";
    } else if (timeDiffence < 60) {
        return [NSString stringWithFormat:@"%d秒前", (int)floor(timeDiffence)];
    } else if (timeDiffence < 3600){
        return [NSString stringWithFormat:@"%d分钟前",(int)floor(timeDiffence / 60)];
    } else if (timeDiffence < 86400){
        return [NSString stringWithFormat:@"%d小时前", (int)floor(timeDiffence / 3600)];
    } else if (timeDiffence < 2592000){
        return [NSString stringWithFormat:@"%d天前", (int)floor(timeDiffence / 3600 / 24)];
    } else if (timeDiffence < 31536000) {
        //    返回具体日期
        NSDate *oldTimeDate = [NSDate dateWithTimeIntervalSince1970: time];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        return [formatter stringFromDate:oldTimeDate];
    } else {
        //    返回具体日期
        NSDate *oldTimeDate = [NSDate dateWithTimeIntervalSince1970: time];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:oldTimeDate];
    }
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

@end
