//
//  Color.h
//  VIPTravel
//
//  Created by 程凯 on 14-6-6.
//  Copyright (c) 2014年 程凯. All rights reserved.
//

#import "NSDate+WQCalendarLogic.h"

@implementation NSDate (WQCalendarLogic)

- (NSDate *)firstDayOfCurrentYear /**<当年首日*/
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    dateComponents.month = 1;
    dateComponents.day = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

- (NSDate *)firstDayOfCurrentMonth /**<当月首日*/
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    dateComponents.month = [[NSDate date] YMDComponents].month;
    dateComponents.day = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

- (NSDate *)dayFormerePreviousYear /**<上一年*/
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dayFormerePreviousWithYear:(NSInteger)yearNum /**<上几年*/
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = yearNum;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dayLastPreviousYear /**<下一年*/
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = + 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dayAfterYears:(NSInteger)years{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = + years;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dayInThePreviousMonth /**<上一个月*/
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dayInThePreviousWithMonth:(NSInteger)monthNum /**<当前一个月以前的第monthNum个月*/
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -monthNum;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDateComponents *)YMDComponents /**<获取年月日对象*/
{
    return [[NSCalendar currentCalendar] components:
            NSCalendarUnitYear|
            NSCalendarUnitMonth|
            NSCalendarUnitDay fromDate:self];
}

+ (NSDate *)dateFromString:(NSString *)dateString /**<NSString转NSDate*/
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
//    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

- (NSString *)stringFromDate:(NSString *) formatString /**<NSDate转(所需格式的)NSString*/
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:formatString];
    
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    return destDateString;
}

+ (NSString *)stringFormString:(NSString *)dateString withDateStringFormat:(NSString *)dateFormate withFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:dateFormate];
    
    NSDate *destDate = [dateFormatter dateFromString:dateString];
//    NSDate *date = [self dateFromString:dateString];
    return [destDate stringFromDate:formatString];
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

- (NSDate *)getLasterDay:(NSInteger)days
{

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = days;
    
    NSLog(@"%ld:%ld:%ld", comps.year, comps.month,comps.day);
    return [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:self options:0];
    
}

@end
