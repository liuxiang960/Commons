//
//  Color.h
//  VIPTravel
//
//  Created by 程凯 on 14-6-6.
//  Copyright (c) 2014年 程凯. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @author 程凯, 15-12-23 15:12:12
 *
 *  @brief 日期格式处理封装
 *
 *  @since 3.2
 */

@interface NSDate (WQCalendarLogic)
- (NSDate *)firstDayOfCurrentYear;/**<当年首日*/

- (NSDate *)firstDayOfCurrentMonth;/**<当月首日*/

- (NSDate *)dayFormerePreviousYear;/**<上一年*/

- (NSDate *)dayFormerePreviousWithYear:(NSInteger)yearNum;/**<上几年*/

- (NSDate *)dayLastPreviousYear;/**<下一年*/

- (NSDate *)dayAfterYears:(NSInteger)years;/**<多少年后*/

- (NSDate *)dayInThePreviousMonth;/**<上一个月*/

- (NSDate *)dayInThePreviousWithMonth:(NSInteger)monthNum;/**<当前一个月以前的第monthNum个月*/

- (NSDateComponents *)YMDComponents;/**<获取年月日对象*/

+ (NSDate *)dateFromString:(NSString *)dateString;/**<NSString转NSDate*/

/**
 *  @author 程凯
 *
 *  将传入日期字符串转成日期
 *
 *  @param dateString 日期字符串
 *  @param format     传入日期的日期格式
 *
 *  @return 日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format;

- (NSString *)stringFromDate:(NSString *) formatString;/**<NSDate转(所需格式的)NSString*/

/**
 *  @author 程凯
 *
 *  将日期字符串转成制定格式的日期字符串
 *
 *  @param dateString   日期字符串
 *  @param dateString   日期字符串的日期格式
 *  @param formatString 转换后的日期格式
 *
 *  @return 转换后的日期字符串
 */
+ (NSString *)stringFormString:(NSString *)dateString withDateStringFormat:(NSString *)dateFormate withFormat:(NSString *)formatString;

/**
 *  @author 程凯
 *
 *  给你一个方法，输入参数是NSDate，输出结果是星期几的字符串
 *
 *  @param inputDate 日期date
 *
 *  @return 星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 *  @author 程凯
 *
 *  返回所给日期的几天后的日期
 *
 *  @param days 天数
 *
 *  @return 几天后的日期
 */
- (NSDate *)getLasterDay:(NSInteger)days;



@end
