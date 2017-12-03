//
//  SeudPublic.m
//  SEUDApp
//
//  Created by 刘湘 on 15/12/22.
//  Copyright © 2015年 chuangwuxian. All rights reserved.
//

#import "SeudPublic.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "AppDelegate.h"
#import "UIColor+helper.h"
#import "MEOHintView.h"
#import "LoginService.h"
@implementation SeudPublic
+(NSString *)getNumToChinaNum:(NSInteger)num{
    if (num==1) {
        return @"1";
    }else if (num==2){
        return @"2";
    }else if (num==3){
        return @"3";
    }else if (num==4){
        return @"4";
    }else if (num==5){
        return @"5";
    }else if (num==6){
        return @"6";
    }else if (num==7){
        return @"7";
    }else if (num==8){
        return @"8";
    }else if (num==9){
        return @"9";
    }else if (num==10){
        return @"10";
    }else {
        return @"null";
    }
}

+(NSString *)getNumToChinaNums:(NSInteger)num{
    if (num==1) {
        return @"一";
    }else if (num==2){
        return @"二";
    }else if (num==3){
        return @"三";
    }else if (num==4){
        return @"四";
    }else if (num==5){
        return @"五";
    }else if (num==6){
        return @"六";
    }else if (num==7){
        return @"七";
    }else if (num==8){
        return @"八";
    }else if (num==9){
        return @"九";
    }else if (num==10){
        return @"十";
    }else {
        return @"null";
    }
}

+ (NSString *)deviceIPAdress {
    return @"00.00.00";
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    if (address.length<=2) {
        return @"192.168.10.176";
    }
    NSLog(@"手机的IP是：%@", address);
    return address;
}

+(NSString*)dictionaryToJson:(id )dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+(BOOL)isStringBaoHanString:(NSString *)zongString  myString:(NSString*)mySting{
    if ([zongString isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if (!zongString) return NO;
    
    if (zongString.length<=0) {
        return NO;
    }
    if ([zongString rangeOfString:mySting].location != NSNotFound) {
        return YES;
    }else{
        return NO;
    }
}

+(NSString *)dateToString:(NSString *)startTime
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"yyyyMMddHHmmss";
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

//格林威治时间转date
+(NSDate *)TimeStringToDate:(NSString *)startTime
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    return date;
}

/**将2017-02-10 9:37:46 转为2017021093746*/
+ (NSString *)newDateToString:(NSString *)dateStr{
    return [self newDateToString:dateStr DateFormatter:@"yyyyMMddHHmmss"];
}

/**将2017-02-10 9:37:46 转为任意时间格式*/
+(NSString *)newDateToString:(NSString *)dateStr DateFormatter:(NSString *)Formatter{
    if (!dateStr&&dateStr.length<1) {
        return @"";
    }
    NSString* string = dateStr;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [outputFormatter setLocale:locale];
    [outputFormatter setDateFormat:Formatter];
    NSString *str1 = [outputFormatter stringFromDate:inputDate];
    return str1;
}

/**将2017-02-10 9:37:46 转为任意时间格式 任意时间格式*/
+(NSString *)newDateToString:(NSString *)dateStr  DateFormatter:(NSString *)Formatter  NewDateFormatter:(NSString *)newForMatter{
    if (!dateStr&&dateStr.length<1) {
        return @"";
    }
    NSString* string = dateStr;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:Formatter];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [outputFormatter setLocale:locale];
    [outputFormatter setDateFormat:newForMatter];
    NSString *str1 = [outputFormatter stringFromDate:inputDate];
    return str1;
}

+(NSString *)MydateToString:(NSString *)startTime
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"yyyy-MM-dd";
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

+(NSString *)MydateToString:(NSString *)startTime Formatter:(NSString*)formatt
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = formatt;
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

+(NSString *)myTimeToString:(NSString *)startTime{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *string = [formatterNew stringFromDate:date];
    //    NSLog(@"%@", string);
    return string;
}

+(NSString *)myTimeSubTimeToString:(NSString *)startTime{
    //    NSDateFormatter *formatter = [NSDateFormatter new];
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    [formatter setTimeZone:timeZone];
    //    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //    [formatter setLocale:locale];
    if (startTime.length>0) {
        NSArray *array=[startTime componentsSeparatedByString:@" "];
        if (array.count==2) {
            NSString *str=array[1];
            return str;
        }else{
            return @"";
        }
    }else{
        return @"";
    }
    
}

+(NSString *)myTimeDateToString:(NSString *)startTime{
    //    NSDateFormatter *formatter = [NSDateFormatter new];
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    [formatter setTimeZone:timeZone];
    //    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //    [formatter setLocale:locale];
    if (startTime.length>0) {
        NSArray *array=[startTime componentsSeparatedByString:@" "];
        if (array.count==2) {
            NSString *str=array[0];
            return str;
        }else{
            return @"";
        }
    }else{
        return @"";
    }
    
}

+(CGFloat)GetTextWidth:(NSString*)text Font:(UIFont*)font Height:(CGFloat)height {
    if(text){
        NSAttributedString * Attributed = [[NSAttributedString alloc] initWithString:text
                                                                          attributes:@{NSFontAttributeName:font}];
        CGSize size = CGSizeMake(10000, height);
        NSRange range = NSMakeRange(0, Attributed.length);
        NSDictionary *tdic = [Attributed attributesAtIndex:0 effectiveRange:&range];
        
        CGSize  actualsize =[[Attributed string] boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        return actualsize.width;
    }else{
        return 5;
    }
}

+(double)jinyiMethod:(double)num
{
    double result ;
    NSString *str = [NSString stringWithFormat:@"%.3f",num];
    NSString *str2 = [str substringWithRange:NSMakeRange(0, str.length-1)];
    if ([str floatValue]-[str2 floatValue]==0) {
        result=[str2 floatValue];
    }else
    {
        result = [str2 floatValue]+0.01;
    }
    if (result<0.01&&result>0) {
        result = 0.01;
    }
    return result;
}

+(double)roundMethod:(double)num
{
    double result ;
    NSString *str = [NSString stringWithFormat:@"%.3f",num];
    NSString *str2 = [str substringWithRange:NSMakeRange(0, str.length-1)];
    if ([str floatValue]-[str2 floatValue]>0.004) {
        result=[str2 floatValue]+0.01;
    }else
    {
        result = [str2 floatValue];
    }
    if (result<0.01&&result>0) {
        result = 0.01;
    }
    return result;
}

+(NSString *)getLastDate:(NSInteger)date{
    NSDate * date1 = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:locale];
    NSTimeInterval time1 = date * 24 * 60 * 60;
    NSDate * lastYear = [date1 dateByAddingTimeInterval:-time1];
    NSString * startDate = [dateFormatter stringFromDate:lastYear];
    return startDate;
}


+(NSString *)timeCodeTotimeStr:(NSString*)str{
    
    if (str==nil||[str  isEqualToString:@""]) {
        NSLog(@"时间为空");
        return @"";
    }
    NSLog(@"%@",str);
    //    NSDate *date1 = [NSDate date];
    //    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    //     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    [dateFormatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //    [dateFormatter setLocale:locale];
    //    NSString *str1=[dateFormatter stringFromDate:date1];
    //    str1=[NSString stringWithFormat:@"%@ 00:00:00",str1];
    //
    //    NSDateFormatter *myforMatter=[[NSDateFormatter  alloc] init];
    //    myforMatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //     [myforMatter setLocale:locale];
    //    [myforMatter setTimeZone:timeZone];
    //    NSDate *myDate=[myforMatter dateFromString:str1];
    //    NSString *str2=[myforMatter stringFromDate:myDate];
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[myDate timeIntervalSince1970]];
    
    double lastactivityInterval = [str doubleValue]*60;
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init] ;
    formatter2.timeZone = timeZone;
    formatter2.locale=locale;
    [formatter2 setDateStyle:NSDateFormatterMediumStyle];
    [formatter2 setTimeStyle:NSDateFormatterShortStyle];
    [formatter2 setDateFormat:@"HH:mm"];
    NSDate* date2 = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    NSString* dateString = [formatter2 stringFromDate:date2];
    return dateString;
}

+(NSString *)myLastTimeToString:(NSString *)startTime{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"HH:mm:ss";
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

//格林威治时间转换
+(NSString *)gelinTimeToString:(NSString *)startTime{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"yyyyMMddHHmmss";
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

+(NSString *)myLastDateToString:(NSString *)startTime{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"yyyy-MM-dd";
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}


+(NSString *)myLastDateToString:(NSString *)startTime Formatter:(NSString *)formatterStr{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"MMM dd',' yyyy hh:mm:ss a";
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = formatterStr;
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

//获取上个月的今天
+ (NSString *)setupRequestDay
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:-1];
    [lastMonthComps setDay:1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    return dateStr;
}


+(NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+(NSString *)getCurrentTime:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+(NSString *)myGetTime:(NSString *)time{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"hh:mm:ss a";
    //    NSDate *date = [formatter dateFromString:time];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"hh:mm:ss";
    return nil;
}

+ (NSDate *)zeroDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    NSTimeInterval addedTimeInterval = [timeZone secondsFromGMTForDate:date];
    //    NSDate *localDate = [NSDate dateWithTimeInterval:addedTimeInterval sinceDate:date];
    //    formatter.timeZone = timeZone;
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:date];
    date = [formatter dateFromString:dateString];
    return date;
}

+ (NSString *)getCurrentTimeDesc
{
    NSDate *currentDate = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSTimeInterval addedTimeInterval = [timeZone secondsFromGMTForDate:currentDate];
    NSDate *localDate = [NSDate dateWithTimeInterval:addedTimeInterval sinceDate:currentDate];
    
    NSTimeInterval timeInterval = [localDate timeIntervalSinceDate:[self zeroDate]];
    
    //    NSString *dateString = [NSString stringWithFormat:@"%@", localDate.description];
    //    NSInteger hour = [[dateString substringWithRange:NSMakeRange(11, 2)] integerValue];
    
    if (timeInterval < (12 + 8) * 3600)
    {
        return @"上午好";
    }
    else
    {
        return @"下午好";
    }
}

+ (NSString *)dateToFormatterString:(NSDate *)date{
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = @"yyyyMMddHHmmss";
    NSString *string = [formatterNew stringFromDate:date];
    return string;
}

+ (NSString *)dateToSString:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    NSString *dateString = [[NSString stringWithFormat:@"%@", localeDate] substringToIndex:10];
    return dateString;
}

+ (NSDate *)stringToDate:(NSString *)string
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSDate *)stringToFullDate:(NSString *)string
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+ (NSString *)oneMonthFromNow
{
    NSDate *date = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval: - 30 * 24 * 3600];
    NSString *dateString = [[NSString stringWithFormat:@"%@", newDate] substringToIndex:10];
    return dateString;
}

+(NSArray *)getStockArray:(NSString*)str{

    return @[];
}

#pragma mark ---- 设置指定文字的颜色
+ (NSAttributedString *)setStringToAttributeStr:(NSString *)dataString strColor:(UIColor *)strColor units:(NSString *)units unitsColor:(UIColor *)unitsColor{
    if (dataString.length>0) {
        NSArray *strArray = [dataString componentsSeparatedByString:units];
        NSString *frontStr = strArray[0];
        NSString *failStr = @"";
        if (strArray.count >= 2) {
            failStr = strArray[1];
        }
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dataString];
        [str addAttribute:NSForegroundColorAttributeName value:strColor range:NSMakeRange(0,frontStr.length)];
        [str addAttribute:NSForegroundColorAttributeName value:unitsColor range:NSMakeRange(frontStr.length,units.length)];
        [str addAttribute:NSForegroundColorAttributeName value:strColor range:NSMakeRange(frontStr.length + units.length,failStr.length)];
        return str;
    }else{
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@""];
        return str;
    }
}


+(NSAttributedString *)addStringToAttributeString:(NSString *)dataString units:(NSString *)units{
    if (dataString.length>0) {
        NSString *dataStr=[NSString stringWithFormat:@"%@%@",dataString,units];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dataStr];
        [str addAttribute:NSForegroundColorAttributeName value:SEUD_Color_White_10 range:NSMakeRange(0,dataString.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:183/255.0 green:187/255.0 blue:196/255.0 alpha:1] range:NSMakeRange(dataString.length,units.length)];
        //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
        //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
        //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
        //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:NSMakeRange(19, 6)];
        return str;
        
    }else{
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@""];
        return str;
    }
}

+(NSAttributedString *)addStringToAttributeStringColor:(NSString *)dataString units:(NSString *)units defualColor:(UIColor *)defualColor falgColar:(UIColor *)flagCloor{
    if (dataString.length>0) {
        NSString *dataStr=[NSString stringWithFormat:@"%@%@张",units,dataString];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dataStr];
        [str addAttribute:NSForegroundColorAttributeName value:defualColor range:NSMakeRange(0,dataString.length)];
        [str addAttribute:NSForegroundColorAttributeName value:flagCloor range:NSMakeRange(units.length,dataString.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, dataStr.length)];
        //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0] range:NSMakeRange(6, 12)];
        //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:15.0] range:NSMakeRange(19, 6)];
        return str;
    }else{
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@""];
        return str;
    }
}

+(NSAttributedString *)addToAttributeStringFontStr:(NSString *)dataString  forntFont:(UIFont *)FoFont  blowSting:(NSString *)blowStr blowFornt:(UIFont *)blowfont MyColor:(UIColor *)Color{
    return [SeudPublic addToAttributeStringFontStr:dataString forntColor:Color forntFont:FoFont blowSting:blowStr blowFornt:blowfont blowColor:Color];
}

+(NSAttributedString *)addToAttributeStringFontStr:(NSString *)dataString forntColor:(UIColor *)fontColor  blowSting:(NSString *)blowStr  blowColor:(UIColor *)blowColor  MyFornt:(UIFont *)font{
    return [SeudPublic addToAttributeStringFontStr:dataString forntColor:fontColor forntFont:font blowSting:blowStr blowFornt:font blowColor:blowColor];
}

+(NSAttributedString *)addToAttributeStringFontStr:(NSString *)dataString forntColor:(UIColor *)fontColor  forntFont:(UIFont *)FoFont  blowSting:(NSString *)blowStr blowFornt:(UIFont *)blowfont blowColor:(UIColor *)blowColor{
    if ([dataString isKindOfClass:[NSNull class]]||[blowStr isKindOfClass:[NSNull class]]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@""];
        return str;
    }
    if (dataString.length<=0||blowStr.length<=0) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@""];
        return str;
    }
    NSString *dataStr=[NSString stringWithFormat:@"%@%@",dataString,blowStr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dataStr];
    [str addAttribute:NSForegroundColorAttributeName value:fontColor range:NSMakeRange(0,dataString.length)];
    [str addAttribute:NSFontAttributeName value:FoFont range:NSMakeRange(0,dataString.length)];
    
    [str addAttribute:NSFontAttributeName value:blowfont range:NSMakeRange(dataString.length, blowStr.length)];
    [str addAttribute:NSForegroundColorAttributeName value:blowColor range:NSMakeRange(dataString.length,blowStr.length)];
    return str;
}

+ (NSAttributedString *)frontText:(NSString *)froText frontFont:(UIFont *)froFont blowText:(NSString *)bloText blowFont:(UIFont *)blowFont{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", froText, bloText]];
    [str addAttribute:NSFontAttributeName value:froFont range:NSMakeRange(0, froText.length)];
    [str addAttribute:NSFontAttributeName value:blowFont range:NSMakeRange(froText.length + 1, bloText.length)];
    return str;
}

//属性字符串
+(NSString *)ChangeNumberFormat:(NSString *)num
{
    
    if (num == nil) {
        return @"";
    }
    return [SeudPublic rtToStandardNumberString:num];
    
    //弃用
    int count = 0;
    long long int a = [num longLongValue];
    if ([num doubleValue]<1000) {
        return num;
    }
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSString *afterStr = [string substringWithRange:NSMakeRange(string.length-3, 3)];
    string = [NSMutableString stringWithString:[string substringWithRange:NSMakeRange(0, string.length-3)]];
    NSMutableString *newstring = [NSMutableString string];
    [newstring insertString:afterStr atIndex:0];
    if (string.length<=3) {
        newstring=(NSMutableString*)[NSString stringWithFormat:@"%@,%@",string,afterStr];
        return newstring;
    }else{
        while (count > 3)
        {
            count -= 3;
            NSRange rang;
            NSInteger temp=string.length-3;
            if (temp<0) {
                temp=temp*-1;
                rang = NSMakeRange(0, temp-1);
                NSString *str = [string substringWithRange:rang];
                [newstring insertString:str atIndex:0];
                [newstring insertString:@"," atIndex:0];
                [string deleteCharactersInRange:rang];
            }else{
                rang = NSMakeRange(string.length - 3, 3);
                NSString *str = [string substringWithRange:rang];
                [newstring insertString:str atIndex:0];
                [newstring insertString:@"," atIndex:0];
                [string deleteCharactersInRange:rang];
            }
            
        }
        [newstring insertString:string atIndex:0];
    }
    return newstring;
}

+ (NSString *)numberConvertToStandardNumberString:(double)number{
    
    return [SeudPublic isFloatToString:[NSString stringWithFormat:@"%.2f",number]];
}
#pragma mark - 金额转换
+(NSString *)moneyToney:(NSString *)money{
    double mymoney=[money doubleValue];
    if (mymoney>=10000) {
        double thirdouble=mymoney/10000.0;
        return [NSString stringWithFormat:@"%.2lf(万)",thirdouble];
    }else{
        return [NSString stringWithFormat:@"%@(元)",money];
    }
}

#pragma mark - 金额转换
+(NSString *)moneyToMoney:(NSString *)money{
    return [SeudPublic moneyAndUntil:money isSaveDecimal:NO];
}

+(NSString *)moneyAndUntil:(NSString *)money isSaveDecimal:(BOOL)bol{
    BOOL isShowTwoBit =bol;//是否位数是0的时候截取后面的0
    if (money.length<=0) {
        if (isShowTwoBit) {
            return @"0";
        }else{
            return @"0.00";
        }
    }
    double mymoney=[money doubleValue];
    if (mymoney>=100000000) {
        double thirdouble=mymoney/100000000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@亿",str1];
        }
        return [NSString stringWithFormat:@"%.2lf亿",thirdouble];
    }else if (mymoney>=10000) {
        double thirdouble=mymoney/10000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@万",str1];
        }
        return [NSString stringWithFormat:@"%.2lf万",thirdouble];
    }else if (mymoney<=-100000000) {
        double thirdouble=mymoney/10000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@亿",str1];
        }
        return [NSString stringWithFormat:@"%.2lf亿",thirdouble];
    }else if (mymoney<=-10000) {
        double thirdouble=mymoney/10000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@万",str1];
        }
        return [NSString stringWithFormat:@"%.2lf万",thirdouble];
    }else{
        return [NSString stringWithFormat:@"%@",money];
    }
}

+(NSString *)keepTwoDecimalMoney:(NSString *)money{
    if (money.length<=0) {
        return @"0.00";
    }
    double mymoney=[money doubleValue];
    if (mymoney>=100000000) {
        double thirdouble=mymoney/100000000.0;
        return [NSString stringWithFormat:@"%.2lf亿",thirdouble];
    }else if (mymoney>=10000) {
        double thirdouble=mymoney/10000.0;
        return [NSString stringWithFormat:@"%.2lf万",thirdouble];
    }else if (mymoney<=-100000000) {
        double thirdouble=mymoney/10000.0;
        return [NSString stringWithFormat:@"%.2lf亿",thirdouble];
    }else if (mymoney<=-10000) {
        double thirdouble=mymoney/10000.0;
        return [NSString stringWithFormat:@"%.2lf万",thirdouble];
    }else{
        return [NSString stringWithFormat:@"%.2lf", mymoney];
    }
}


#pragma mark - 数量转换
+(NSString *)NumToNumStr:(NSString *)num{
    BOOL isShowTwoBit =NO;
    if ([num isKindOfClass:[NSString class]]) {
        if (num.length<=0) {
            return @"0";
        }else if ([num isEqualToString:@"--"]) {
            return num;
        }
    }
    double mymoney=[num doubleValue];
    if (mymoney<10000) {
        return [NSString stringWithFormat:@"%.0f",mymoney];
    }
    if (mymoney>=100000000) {
        double thirdouble=mymoney/100000000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@亿",str1];
        }
        return [NSString stringWithFormat:@"%.2lf亿",thirdouble];
    }else if (mymoney>=10000) {
        double thirdouble=mymoney/10000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@万",str1];
        }
        
        return [NSString stringWithFormat:@"%.2lf万",thirdouble];
    }else if (mymoney<=-100000000) {
        double thirdouble=mymoney/10000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@万",str1];
        }
        return [NSString stringWithFormat:@"%.2lf万",thirdouble];
    }else if (mymoney<=-10000) {
        double thirdouble=mymoney/10000.0;
        NSString *str=[NSString stringWithFormat:@"%.2lf",thirdouble];
        NSString *str1=[NSString stringWithFormat:@"%.0lf",thirdouble];
        if ([str1 doubleValue]==[str doubleValue]&&isShowTwoBit) {
            
            return [NSString stringWithFormat:@"%@万",str1];
        }
        return [NSString stringWithFormat:@"%.2lf万",thirdouble];
    }else{
        return [NSString stringWithFormat:@"%@",num];
    }
}

#pragma mark - 金额转换
+(NSString *)numToNum:(NSString *)num{
    return  [SeudPublic NumToNumStr:num];
}

+ (NSString *)rtToStandardNumberString:(NSString *)numberStr
{
    if(!numberStr){
        return @"0.00";
    }
    if ([numberStr isKindOfClass:[NSString class]]) {
        if ([numberStr isEqualToString:@"--"]) {
            return @"--";
        }else if ( [numberStr isEqualToString:@"nsnull"]) {
            return @"0.00";
        }
    }
    if ([numberStr isKindOfClass:[NSNull class]] ) {
        return @"--";
    }
    if (!numberStr||[numberStr doubleValue]==0.00) {
        return @"0.00";
    }
    if ([numberStr isKindOfClass:[NSString class]]&&[SeudPublic isStringBaoHanString:numberStr myString:@","]) {
        numberStr=[numberStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    numberStr=[SeudPublic isFloatToString:numberStr];
    double number=[numberStr doubleValue];
    //    if (number>=0&& number<1000) {
    //        NSString *tempStr=[NSString stringWithFormat:@"%.2f",number];
    //        NSArray *pintArray=[tempStr componentsSeparatedByString:@"."];
    //        NSString *str=pintArray[1];
    //        if ([str floatValue]==0.00) {
    //            return pintArray[0];
    //        }
    //        return tempStr;
    //    }
    // 1234567890.12645  加入千分位符, 并四舍五入保留2位小数 1,234,567,890.13
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"###,##0.00"];
    
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    //        if ([SeudPublic isStringBaoHanString:formattedNumberString myString:@"."]) {
    //            NSArray *array=[formattedNumberString componentsSeparatedByString:@"."];
    //            NSString *str=array[1];
    //            if ([str floatValue]<=0.00) {
    //                return array[0];
    //            }
    //        }
    return formattedNumberString;
}

+(NSString*)rtToStandardNumberStringAddSymbolic:(NSString *)str{
    NSString *strData=[SeudPublic rtToStandardNumberString:str];
    if ([str doubleValue]>0) {
        strData=[NSString stringWithFormat:@"+%@",strData];
    }
    
    return strData;
}


+ (NSString *)rtToStandardNumberMoney:(NSString *)money
{
    
    NSString *numberStr=money;
    if ([numberStr isKindOfClass:[NSString class]]) {
        if ([numberStr isEqualToString:@"--"]) {
            return @"--";
        }
    }
    if (!numberStr||[numberStr doubleValue]==0.00) {
        return @"0.00";
    }
    numberStr=[SeudPublic isFloatToString:numberStr];
    double number=[numberStr doubleValue];
    if (number>=0&& number<1000) {
        NSString *tempStr=[NSString stringWithFormat:@"%.2f",number];
        NSArray *pintArray=[tempStr componentsSeparatedByString:@"."];
        NSString *str=pintArray[1];
        if ([str floatValue]==0.00) {
            return pintArray[0];
        }
        return tempStr;
    }
    // 1234567890.12645  加入千分位符, 并四舍五入保留2位小数 1,234,567,890.13
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"###,##0.00"];
    
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
//    if ([SeudPublic isStringBaoHanString:formattedNumberString myString:@"."]) {
//        NSArray *array=[formattedNumberString componentsSeparatedByString:@"."];
//        NSString *str=array[1];
//        if ([str floatValue]<=0.00) {
//            return array[0];
//        }
//    }
    return formattedNumberString;
}



+ (NSString *)rtToStandardNumberStringThirs:(NSString *)numberStr
{
    if ([numberStr isKindOfClass:[NSString class]]) {
        if ([numberStr isEqualToString:@"--"]) {
            return @"--";
        }
    }
    if (!numberStr||[numberStr doubleValue]==0.00) {
        return @"0.000";
    }
    double number=[numberStr doubleValue];
    if (number>=0&& number<1000) {
        
        return [NSString stringWithFormat:@"%.3f",number];
    }
    // 1234567890.12645  加入千分位符, 并四舍五入保留2位小数 1,234,567,890.13
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"###,##0.000"];
    
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    
    return formattedNumberString;
}

+ (NSString *)rtToStandardNumberStringTxt:(NSString *)numberStr{
    if(!numberStr||[numberStr isKindOfClass:[NSNull class]]){
        return @"0";
    }
    if ([numberStr isKindOfClass:[NSString class]]) {
        if ([numberStr isEqualToString:@"--"]) {
            return @"--";
        }
    }
    if (!numberStr||[numberStr doubleValue]<=0.00) {
        return [SeudPublic islongToString:numberStr];
    }
    
    if ([numberStr isKindOfClass:[NSString class]]&&[SeudPublic isStringBaoHanString:numberStr myString:@","]) {
        numberStr=[numberStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    numberStr=[SeudPublic islongToString:numberStr];
    BOOL isPoint=NO;
    if ([SeudPublic isStringBaoHanString:numberStr myString:@"."]) {
        isPoint=YES;
    }else{
        isPoint=NO;
    }
    double number ;
    
    NSArray * array=[numberStr componentsSeparatedByString:@"."];
    number=[array[0] doubleValue];
    if (number>0&& number<1000) {
        
        return numberStr;
    }
    // 1234567890.12645  加入千分位符, 并四舍五入保留2位小数 1,234,567,890.13
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"###,###;"];
    
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    if (isPoint) {
        NSString *st=[NSString stringWithFormat:@".%@",array[1]];
        if ([st doubleValue]<=0.00) {
            st=@".";
        }
        formattedNumberString=[NSString stringWithFormat:@"%@%@",formattedNumberString,st];
    }
    return formattedNumberString;
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    if ([jsonString isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)jsonString;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+(BOOL)isGetVerSion{
    
    return NO;
}

+(BOOL)isHidenHomeAd{
    return NO;
}

+(void)mysetLostHost:(NSString *)hostHerder{
    NSString *MyHost;
//    MyHost = @"http://192.168.70.98:8080";
//    NSUserDefaults *userDefaults1 = [NSUserDefaults standardUserDefaults];
//    [userDefaults1 setObject:MyHost forKey:@"MyHost"];
//    return;
        if (![self isStringBaoHanString:hostHerder myString:@"http:"]) {
            if ([self isStringBaoHanString:hostHerder myString:@":4000"]) {
                hostHerder=[hostHerder stringByReplacingOccurrencesOfString:@":4000" withString:@":9000"];
            }
        }else{
            if ([self isStringBaoHanString:hostHerder myString:@":4000"]) {
                hostHerder=[hostHerder stringByReplacingOccurrencesOfString:@":4000" withString:@":9000"];
            }
        }
    NSArray* list = [hostHerder componentsSeparatedByString:@":"];
#if VER_TYPE == 3
    
    MyHost = [NSString stringWithFormat:@"https://%@",[list objectAtIndex:0]];
#else
    if([SeudPublic isStringBaoHanString:[list objectAtIndex:0] myString:@"http://"]){
        MyHost = [NSString stringWithFormat:@"%@",[list objectAtIndex:1]];
    }else{
        MyHost = [NSString stringWithFormat:@"http://%@:%@",[list objectAtIndex:0],[list objectAtIndex:1]];
    }
#endif
    NSLog(@"%@",MyHost);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:MyHost forKey:@"MyHost"];
}

+(NSString *)getHostHeader{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str =[userDefaults objectForKey:@"MyHost"];
    return str;
}

+(UILabel *)isdataColor:(NSString *)str cha:(NSString *)chaStr myLable:(UILabel *)lable{
    if (chaStr.length>0) {
        CGFloat temp=[chaStr floatValue];
        if ([str floatValue]>temp) {
            lable.textColor=[UIColor colorWithHexString:@"ED2C44" withAlpha:1];
            
        }else if ([str floatValue]==temp){
            lable.textColor=SEUD_Color_Standard_Gray_11;
        }else{
            lable.textColor=[UIColor colorWithHexString:@"439927" withAlpha:1];
        }
    }else{
        if ([str floatValue]>0) {
            lable.textColor=[UIColor colorWithHexString:@"ED2C44" withAlpha:1];
            
        }else if ([str floatValue]==0){
            lable.textColor=SEUD_Color_Standard_Gray_11;
        }else{
            lable.textColor=[UIColor colorWithHexString:@"439927" withAlpha:1];
        }
        
    }
    return lable;
}

+(UIColor *)isdataColor:(NSString *)str cha:(NSString *)chaStr {
    if ([str isKindOfClass:[NSString class]]) {
        if ([str isEqualToString:@"--"]) {
            return SEUD_Color_Standard_Gray_11;
        }
        if ([SeudPublic isStringBaoHanString:str myString:@"¥"]) {
            str=[str stringByReplacingOccurrencesOfString:@"¥" withString:@""];
        }
    }
    NSString *strx=[NSString stringWithFormat:@"%.2f",[str floatValue]];
    str=[strx stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *stry=[NSString stringWithFormat:@"%.2f",[chaStr floatValue]];
    chaStr=[stry stringByReplacingOccurrencesOfString:@"," withString:@""];
    UIColor *color=[UIColor clearColor];
    if (chaStr.length>0) {
        CGFloat temp=[chaStr floatValue];
        if ([str doubleValue]==0) {
            color=SEUD_Color_Standard_Gray_11;
            return color;
        }
        if ([str floatValue]>temp) {
            color=[UIColor colorWithHexString:@"ED2C44" withAlpha:1];
            
        }else if ([str floatValue]==temp){
            color=SEUD_Color_Standard_Gray_11;
        }else{
            color=SEUD_Color_Standard_Green_2;
        }
    }else{
        if ([str floatValue]>0) {
            color=[UIColor colorWithHexString:@"ED2C44" withAlpha:1];
            
        }else if ([str floatValue]==0){
            color=SEUD_Color_Standard_Gray_11;
        }else{
            color=SEUD_Color_Standard_Green_2;
        }
        
    }
    return color;
}


+(void)isOrderPushServerCall:(NSString *)server TypeDic:(NSDictionary *)typeDic{
    if(!typeDic||server.length<=0){
        return;
    }
   
}


+(void)isUnOrderPushServerCall:(NSString *)server TypeDic:(NSDictionary *)typeDic{
   
}

+(NSString *)islongToString:(id)data{
    if (data==nil) {
        return @"0";
    }
    if (data&&![data isKindOfClass:[NSNull   class]]) {
        if ([data isKindOfClass:[NSString class]]) {
            NSString *da=(NSString *)data;
            if ([da isEqualToString:@"--"]) {
                return da;
            }else if ([data isEqualToString:@"null"]||[data isEqualToString:@"<null>"]){
                return @"0";
            }
        }
        return [NSString stringWithFormat:@"%ld",(long)[data integerValue]];
    }else{
        return @"0";
    }
}

+(NSString *)isFloatToString:(id)data{
    if (data==nil) {
        return @"0.00";
    }
    if (data&&![data isKindOfClass:[NSNull   class]]) {
        if ([data isKindOfClass:[NSString class]]) {
            NSString *da=(NSString *)data;
            if ([da isEqualToString:@"--"]) {
                return da;
            }else if ([data isEqualToString:@"null"]||[data isEqualToString:@"<null>"]){
                return @"0.00";
            }
        }
        NSString *str=[NSString stringWithFormat:@"%.2f",[data doubleValue]];
        if ([str isEqualToString:@"0.00"]) {
            return str;
        }
        //        if ([str doubleValue]>999.99) {
        //            NSString *str1=[NSString stringWithFormat:@"%.0f",[data doubleValue]];
        //            if ([str1 doubleValue]==[str doubleValue]) {
        //                return str1;
        //            }
        //        }
        return str;
    }else{
        return @"0.00";
    }
}



+ (UIViewController*)findTopViewController
{
    id  topControler  = [SeudPublic topMostController];
    UIViewController* topViewController;
    
    if([topControler isKindOfClass:[UINavigationController class]])
    {
        topViewController = [[(UINavigationController*)topControler viewControllers] lastObject];
    }
    else if ([topControler isKindOfClass:[UITabBarController class]])
    {
        topViewController = [(UITabBarController *)topControler selectedViewController];
        if ([topViewController isKindOfClass:[UINavigationController class]])
        {
            topViewController = [[(UINavigationController *)topViewController viewControllers] lastObject];
        }
        
    }
    else
    {
        topViewController = (UIViewController*)topControler;
    }
    
    return topViewController;
}

+ (UIViewController*)topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    return topController;
}


+(NSString *)isAddTenYear:(NSString *)dateStr{
    if (dateStr.length<5) {
        return @"";
    }else{
        NSArray *temp=[dateStr componentsSeparatedByString:@"-"];
        if (temp.count>=2) {
            NSString *str=temp[0];
            str=[NSString stringWithFormat:@"%ld-%@-%@",[str integerValue]+10,temp[1],temp[2]];
            return str;
        }else{
            return @"";
        }
    }
    
}

+(NSString *)isAddYear:(NSString *)dataStr Years:(NSInteger) year{
    if (dataStr.length<5||year<=0) {
        return @"";
    }else{
        NSArray *temp=[dataStr componentsSeparatedByString:@"-"];
        if (temp.count>=2) {
            NSString *str=temp[0];
            str=[NSString stringWithFormat:@"%ld-%@-%@",[str integerValue]+year,temp[1],temp[2]];
            return str;
        }else{
            return @"";
        }
    }
}

+ (BOOL)compareStartDateStr:(NSString *)sDateStr withEndDate:(NSString *)eDateStr
{
    NSDate *sDate=[SeudPublic stringToDate:sDateStr];
    NSDate *eDate=[SeudPublic stringToDate:eDateStr];
    BOOL flag = NO;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit;
    NSDateComponents *cpt = [calendar components:units fromDate:sDate];
    NSInteger year5 = cpt.year + 5;
    NSInteger year10 = cpt.year + 10;
    NSInteger year20 = cpt.year + 20;
    
    NSDateComponents *newCpt5 = [[NSDateComponents alloc] init];
    newCpt5.year = year5;
    newCpt5.month = cpt.month;
    newCpt5.day = cpt.day;
    
    NSDateComponents *newCpt10 = [[NSDateComponents alloc] init];
    newCpt10.year = year10;
    newCpt10.month = cpt.month;
    newCpt10.day = cpt.day;
    
    NSDateComponents *newCpt20 = [[NSDateComponents alloc] init];
    newCpt20.year = year20;
    newCpt20.month = cpt.month;
    newCpt20.day = cpt.day;
    
    NSDate *date5yrs = [calendar dateFromComponents:newCpt5];
    NSDate *date10yrs = [calendar dateFromComponents:newCpt10];
    NSDate *date20yrs = [calendar dateFromComponents:newCpt20];
    
    if ([eDate isEqualToDate:date10yrs] || [eDate isEqualToDate:date20yrs] || [eDate isEqualToDate:date5yrs])
    {
        flag = YES;
    }
    return flag;
}


+ (BOOL)compareStartDate:(NSDate *)sDate withEndDate:(NSDate *)eDate
{
    BOOL flag = NO;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit;
    NSDateComponents *cpt = [calendar components:units fromDate:sDate];
    NSInteger year10 = cpt.year + 10;
    NSInteger year20 = cpt.year + 20;
    
    NSDateComponents *newCpt10 = [[NSDateComponents alloc] init];
    newCpt10.year = year10;
    newCpt10.month = cpt.month;
    newCpt10.day = cpt.day;
    
    NSDateComponents *newCpt20 = [[NSDateComponents alloc] init];
    newCpt20.year = year20;
    newCpt20.month = cpt.month;
    newCpt20.day = cpt.day;
    
    NSDate *date10yrs = [calendar dateFromComponents:newCpt10];
    NSDate *date20yrs = [calendar dateFromComponents:newCpt20];
    
    if ([eDate isEqualToDate:date10yrs] || [eDate isEqualToDate:date20yrs])
    {
        flag = YES;
    }
    return flag;
}


+(NSString *)trasUpdateMoney:(double)money
{
    double tempMoney = money;
    money = fabs(money);
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿"];
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",money];
    NSString *prefix;
    NSString *suffix;
    if (money<1) {
        prefix=@"";
        if (money==0) {
            suffix=@"零角零分";
        }
        else if (money<0.1)
        {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr doubleValue]*100]];
        }
        else
        {
            valstr = [valstr substringFromIndex:2];
            NSString *head=[valstr substringToIndex:1];
            NSString *foot=[valstr substringFromIndex:1];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
        }
    }
    else
    {
        prefix=@"";
        suffix=@"";
        NSInteger flag=valstr.length-2;
        NSString *head=[valstr substringToIndex:flag-1];
        NSString *foot=[valstr substringFromIndex:flag];
        //处理整数部分
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
        }
        int zeronum=0;
        
        for (int i=0; i<ch.count; i++) {
            int index=(ch.count -i-1)%4;//取段内位置
            NSInteger indexloc=(ch.count -i-1)/4;//取段位置
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum++;
            }
            else
            {
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix =[prefix stringByAppendingString:@"元"];
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        }
        else if ([foot hasPrefix:@"0"])
        {
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"零%@分",[numberchar objectAtIndex:[footch intValue] ]];
        }
        else
        {
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch  intValue]]];
        }
    }
    if (tempMoney<0) {
         return [NSString stringWithFormat:@"负%@",[prefix stringByAppendingString:suffix]];
    }else{
        return [prefix stringByAppendingString:suffix];
    }
}

//判断身份证
+(BOOL)IsIDCodeExactn:(NSString *)idCar{
    if (idCar.length>10) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSString *tempStr = [formatter stringFromDate:date];
        /*
         tempStr = [tempStr substringToIndex:4];
         NSInteger year = [tempStr integerValue]- [[idCar substringWithRange:NSMakeRange(6,4)] integerValue];
         if (year<18) {
         [MEOHintView showHintViewWith:_T(@"身份证年龄不合法，必须大于18岁才能开户！", @"100028")];
         return NO;
         }else if(year>65)
         {
         [MEOHintView showHintViewWith:_T(@"身份证年龄不合法，必须小于65岁才能开户！", @"120028")];
         return NO;
         }
         */
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        if (idCar.length <18)  {
            [MEOHintView showHintViewWith:_T(@"请输入正确的身份证号码!", @"100027")];
            return NO;
        };
        NSInteger year = [tempStr integerValue]- [[idCar substringWithRange:NSMakeRange(6,8)] integerValue];
        if (year<180000) {
            [MEOHintView showHintViewWith:_T(@"身份证年龄不合法，必须大于18岁才能开户！", @"100028")];
            return NO;
        }else if(year>650000)
        {
            [MEOHintView showHintViewWith:_T(@"身份证年龄不合法，必须小于65岁才能开户！", @"120028")];
            return NO;
        }
    }
    return YES;
}

+ (BOOL)checkOutIDCardSexWithString:(NSString*)str {
    BOOL isBoy ;
    NSString * sexStr =[str substringWithRange:NSMakeRange(str.length-2, 1)];
    NSInteger sex = [sexStr integerValue];
    isBoy = sex % 2 == 0 ? NO : YES;
    return isBoy;
}
//将2016-5-1转换成2016.5.31
+ (NSMutableString *)exchangeStr:(NSString *)str{
    NSMutableString *string = [NSMutableString stringWithString:str];
    
    [string replaceOccurrencesOfString:@"-" withString:@"." options:NSLiteralSearch range:NSMakeRange(0, [str length])];
    return string;
}

//将2016.5.31转换成2016-5-31
+ (NSMutableString *)exchangeString:(NSString *)str{
    NSMutableString *string = [NSMutableString stringWithString:str];
    
    [string replaceOccurrencesOfString:@"." withString:@"-" options:NSLiteralSearch range:NSMakeRange(0, [str length])];
    return string;
}

//将2016-5-1转换成2016/5/31
+ (NSMutableString *)exchangeStrings:(NSString *)str{
    NSMutableString *string = [NSMutableString stringWithString:str];
    
    [string replaceOccurrencesOfString:@"-" withString:@"/" options:NSLiteralSearch range:NSMakeRange(0, [str length])];
    return string;
}


//将string转化为“2016-06-07 15：00：00”的nsdate
+ (NSDate *)stringToMyDate:(NSString *)string{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:string];
    return date;
}



+(NSInteger)IsChinese:(NSString *)str{
    NSInteger X=0;
    for(int i=0; i< [str length];i++){ int a = [str characterAtIndex:i]; if( a > 0x4e00 && a < 0x9fff)
    {
        X++;
        
    }
    }
    return X;
}

+(BOOL)IsChineseBool:(unichar)str{
    
    if( str > 0x4e00 && str < 0x9fff)
    {
        return YES;
        
    }
    return NO;
}

//金额取绝对值
+(double)nsnumberAndStringToFabs:(id)nsnumberOrString{
    return fabs([nsnumberOrString doubleValue]);
}

+(NSString *)nsnumberAndStringToFabsStr:(id)nsnumberOrString{
    return [NSString stringWithFormat:@"%f", fabs([nsnumberOrString doubleValue])];
}

/**计算文字的高度和长度*/
+ (CGSize)textHeightStr:(NSString *)str font:(CGFloat )font labelWidth:(CGFloat)width{
    UIFont *tfont = [UIFont systemFontOfSize:font];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize sizeText = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return sizeText;
}

+(BOOL)isBegin:(NSString *)BeginDate  end:(NSString *)endDate{
    
    if (BeginDate.length<3) {
        [MEOHintView showHintViewWith:_T(@"有效期开始时间不能为空！", @"100035")];
        return NO ;
    }
    //        if ([self validateDate1:[SeudPublic  getCurrentTime] endDate:BeginDate] == NO) {
    //            [MEOHintView showHintViewWith:_T(@"有效期开始时间必须小于或等于当天日期!", @"100034")];
    //            return NO ;
    //        }
    
    if ([self validateDate1:BeginDate endDate:[SeudPublic  getCurrentTime] ] == NO) {
        [MEOHintView showHintViewWith:_T(@"有效期开始时间必须小于或等于当天日期!", @"100034")];
        return NO ;
    }
    return YES;
    //    if ([[SeudPublic stringToDate:endDate] compare:[SeudPublic stringToDate:[SeudPublic getCurrentTime]]] == NSOrderedAscending) {
    //        [MEOHintView showHintViewWith:_T(@"有效期截止时间必须大于或等于当天日期!", @"100036")];
    //        return NO;
    //    }
    
    //        if ([SeudPublic validateDate:endDate endDate:[SeudPublic  getCurrentTime]]==YES) {
    //            [MEOHintView showHintViewWith:@"有效期结束时间必须大于或等于当天日期!"];
    //
    //            return NO;
    //        }
    
    //        BOOL temp=[SeudPublic compareStartDateStr:BeginDate withEndDate:endDate];
    //        if (!temp) {
    //            [MEOHintView showHintViewWith:_T(@"身份证有效期只能为5年、10年、20年或长期有效", @"500012")];
    //
    //            return NO;
    //        }
    
    return YES;
}

+ (BOOL)validateDate1:(NSString *)startTime endDate:(NSString *)endTime
{
    BOOL flag = NO;
    NSDate *startDate   = [SeudPublic stringToDate:startTime];
    NSDate *endDate     = [SeudPublic stringToDate:endTime];
    NSComparisonResult result = [startDate compare:endDate];
    
    if (result == NSOrderedAscending || result == NSOrderedSame) {
        flag = YES;
    }
    
    //    if ([[endDate earlierDate:startDate] isEqualToDate:endDate])
    //    {
    //        flag = NO;
    //    }
    return flag;
}



+(BOOL)validateDate:(NSString *)startTime endDate:(NSString *)endTime
{
    BOOL flag = YES;
    if([startTime isEqualToString:endTime]){
        return flag;
    }else{
        NSDate *startDate   = [SeudPublic stringToDate:startTime];
        NSDate *endDate     = [SeudPublic stringToDate:endTime];
        if ([[endDate earlierDate:startDate] isEqualToDate:endDate])
        {
            flag = NO;
        }
        return flag;
    }
}




+(NSString *)limitInputChar:(NSString *)dataStr  untils:(NSString *)str  limitNum:(NSInteger)num{
    NSString *strNum=[NSString stringWithFormat:@"%@%@",dataStr,str];
    NSInteger chease=[SeudPublic IsChinese:strNum];
    NSInteger engsh=strNum.length-chease;
    if (chease==0) {
        if (strNum.length>num) {
            NSString *str=[strNum substringWithRange:NSMakeRange(0, num)];
            return str;
        }else{
            return strNum;
        }
    }else if (engsh==0){
        if (strNum.length>num/2) {
            NSString *str=[strNum substringWithRange:NSMakeRange(0, num/2)];
            return str;
        }else{
            return strNum;
        }
    } else{
        if (engsh+chease*2<=num) {
            return strNum;
        }else{
            NSInteger j=0;
            for(int i=0;i<strNum.length;i++){
                unichar str= [strNum characterAtIndex:i];
                BOOL temp=[SeudPublic IsChineseBool:str];
                if (temp) {
                    j+=2;
                }else{
                    j+=1;
                }
                if (j==num) {
                    NSString *strX=[strNum substringWithRange:NSMakeRange(0, i+1)];
                    return strX;
                }else if (j>num){
                    NSString *strX=[strNum substringWithRange:NSMakeRange(0, i)];
                    return strX;
                }
                
            }
            
        }
        
    }
    return @"";
}

+(void)loadUserStatusData:(LoadUserInfoCallback)callback{
    [LoginService loadUserStatusData:^(BOOL success, int code, NSString *desc, NSObject *data) {
        callback(success,code,desc,data);
    }];
   
    
    [LXAllServiceApi qryCityListCallBack:^(BOOL success, int code, NSString *desc, NSObject *data) {
        if (success && ![data isKindOfClass:[NSNull class]])
        {
            NSDictionary *dic = (NSDictionary *)data;
            DE.formData = dic;
        }
    }];
}

+(void)loadUserStatusData
{
    [self loadUserStatusData:^{
        
    }];
}



//时间格式转时间戳  获取时间差值
+(NSString* )isGetdate:(NSString *)time addDate:(NSInteger)addDate typeFormatter:(NSString*)type{
    if (time.length<=0) {
        return @"";
    }
    addDate=addDate+[time integerValue]+1;
    NSString *str= [self dateFromTime:addDate typeFormatter:type];
    return str;
}

+(NSString*)dateFromTime:(long)time typeFormatter:(NSString*)type{
    if (time<=0) {
        return @"";
    }
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time*60*60*24];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    [formatter setLocale:locale];
    if (type.length<=0) {
        [formatter setDateFormat:@"YYYY-MM-dd"];
    }else{
        [formatter setDateFormat:type];
    }
    return [formatter stringFromDate:date];
}


+(NSString *)dateToTimeIntervalsince:(NSString *)date{
    if([date isKindOfClass:[NSNull class]]||date.length<=0){
        return @"";
    }else{
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [df setTimeZone:timeZone];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        [df setLocale:locale];
        
        [df setDateFormat:@"yyyyMMdd"];
        NSDate* dateX = [df dateFromString:date];
        long timestamp = [dateX timeIntervalSince1970];
        timestamp /= 60*60*24;
        return [NSString stringWithFormat:@"%ld",timestamp];
    }
}

+(NSDate*)dateFromString:(NSString*)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:dateStr];
    return date;
}

////时间格式转时间戳  获取时间差值
//+(NSString* )isGetdate:(NSString *)time addDate:(NSInteger)addDate{
//    addDate+=1;
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyyMMdd"];
//    NSDate* date = [df dateFromString:time];
//    long timestamp = [date timeIntervalSince1970];
//    timestamp /= 60*60*24;
//    timestamp+=addDate;
//    NSString *str= [self dateFromTime:timestamp];
//    return str;
//}
//
//+(NSString*)dateFromTime:(long)time{
//    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time*60*60*24];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    [formatter setLocale:locale];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    return [formatter stringFromDate:date];
//}
#pragma mark ---- 计算中英混排的字符串的长度
+ (int)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return [da length];
}

//判断是不是周末
+ (NSString *)calculateWeek:(NSString *)dateStr{
    //计算week数
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [df setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate* dateX = [df dateFromString:dateStr];
    NSInteger week = [[myCalendar components:NSWeekdayCalendarUnit fromDate:dateX] weekday];
    switch (week) {
        case 1:
        {
            return @"周日";
        }
        case 2:
        {
            return @"周一";
        }
        case 3:
        {
            return @"周二";
        }
        case 4:
        {
            return @"周三";
        }
        case 5:
        {
            return @"周四";
        }
        case 6:
        {
            return @"周五";
        }
        case 7:
        {
            return @"周六";
        }
    }
    
    return @"";
}

//判断密码安全性的强度，返回字符串：弱、中、强
+ (NSString*)judgePasswordStrong:(NSString*)password

{
    
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    
    NSString *result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:password]];
    
    NSString *result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:password]];
    
    NSString *result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:password]];
    
    NSString *result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:password]];
    
    
    
    [resultArray addObject:result1];
    
    [resultArray addObject:result2];
    
    [resultArray addObject:result3];
    
    [resultArray addObject:result4];
    
    
    
    int intResult=0;
    
    for (int j=0; j<[resultArray count]; j++)
        
    {
        
        
        
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
            
        {
            intResult++;
        }
        
    }
    
    NSInteger length = password.length;
    NSString* resultString = @"";
    
    if (length < 6 || intResult < 2) {
        resultString = @"弱";
    }
    
    if (intResult == 2 && length >= 6 && length <= 8)
        
    {
        
        resultString = @"中";
        
    }
    
    if ((intResult > 2 && [password length] >= 6) || (intResult == 2 && length > 8))
        
    {
        
        resultString = @"强";
        
    }
    
    
    
    return resultString;
    
}

+ (BOOL)judgeRange:(NSArray *)termArray Password:(NSString *)password
{
    NSRange range;
    
    BOOL result =NO;
    
    for(int i=0; i<[termArray count]; i++)
        
    {
        
        range = [password rangeOfString:[termArray objectAtIndex:i]];
        
        if(range.location != NSNotFound)
            
        {
            
            result =YES;
            
        }
        
    }
    
    return result;
}

/**
 *  @author xiang
 *
 *  时间转时间戳
 *
 *  @return 时间戳
 */

+(NSString *)dateToInterval:(NSString *)date{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *dateTime = [formatter dateFromString:date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTime timeIntervalSince1970]];
    return timeSp;
}


+(UIViewController *)getStoryboard{
   
    return nil;
}

/**
 *  @author xiang
 *
 *  获取当前的时间戳
 *
 *  @return 当前的时间戳
 */
+(NSString *)getCurrentInterval{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSString *endInterVal =[SeudPublic dateToInterval:dateTime];
    return endInterVal;
}


+(NSString *)myDateToDate:(NSString *)startTime startFormatter:(NSString *)starformatterStr  dateToFormatter:(NSString *)formatterDate{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    formatter.dateFormat =starformatterStr;
    NSDate *date = [formatter dateFromString:startTime];
    NSDateFormatter *formatterNew = [NSDateFormatter new];
    formatterNew.dateFormat = formatterDate;
    NSString *string = [formatterNew stringFromDate:date];
    NSLog(@"%@", string);
    return string;
}

+(NSString *)DateFormatterStart:(NSString*)start toFormatter:(NSString *)formatter{
    return [SeudPublic myDateToDate:start startFormatter:@"yyyy-MM-dd HH:mm:ss" dateToFormatter:@"yyyy/MM/dd"];
}

#pragma mark - 获取波动价格范围
+(double)isGetFloatedPrice:(NSString *)price{
    double myFloat=0.0;
  myFloat =  [self minWavePrice:price];
    if (myFloat != 0.0) {
        return myFloat;
    }
    if (price.length<=0) {
        return 0.01;
    }
    double temp=[price doubleValue];
    if (temp<=0) {
        return 0.01;
    }
    if (0.01<=temp&&temp<=20.00) {
        myFloat=0.01;
    }else if (20.00<temp&&temp<=100.00){
        myFloat=0.05;
    }else if (100.00<temp&&temp<=200.00){
        myFloat=0.10;
    }else if (200.00<temp&&temp<=1000.00){
        myFloat=0.5;
    }else if (1000.00<temp&&temp<=2000.00){
        myFloat=1.0;
    }else if (2000.00<temp&&temp<=10000.00){
        myFloat=5.0;
    }else if (temp>10000.00){
        myFloat=10.0;
    }
    return myFloat;
}
+ (double)minWavePrice:(NSString*)price {
    double temp = 0.0;
    if (DE.minPriceArray) {
        NSNumber *maxPrice ;
        NSNumber *minPrice ;
        NSNumber *waveUnit ;
        for (NSDictionary *dict in DE.minPriceArray) {
            maxPrice = dict[@"maxPrice"];
            minPrice = dict[@"minPrice"];
            waveUnit = dict[@"waveUnit"];
            if (minPrice.doubleValue < price.doubleValue && price.doubleValue <= maxPrice.doubleValue) {
                temp = waveUnit.doubleValue;
                break;
            }
        }
    }
    return temp;
}

#pragma mark - 写入Plist
+(void)isWriteFieil:(NSDictionary *)info tabName:(NSString *)name{
    //把数据保存到沙盒里的plist文件
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *plistPath1= [paths objectAtIndex:0];
    NSString *  plistPath1 =@"/Users/lx960/Desktop";
    NSLog(@"%@",plistPath1);
    //得到完整的路径名
    if (name) {
        name =[name stringByAppendingString:@".plist"];
    }else{
        name = @"cityCode.plist";
    }
    NSString *fileName = [plistPath1 stringByAppendingPathComponent:name];
    //NSMutableDictionary *myDic = [[NSMutableDictionary alloc]init];
    //[myDic setValuesForKeysWithDictionary:cityDic];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm createFileAtPath:fileName contents:nil attributes:nil] ==YES) {
        
        [info writeToFile:fileName atomically:YES];
        NSLog(@"文件写入完成");
    }
    
}


//绝对布局
+ (void)cornerRadiusWith:(UIView*)view corners:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds      byRoundingCorners:corners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
//相对布局
+ (void)cornerRadiusWith:(UIView*)view corners:(UIRectCorner)corners viewRect:(CGRect)rect{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect     byRoundingCorners:corners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+(NSString *)standardNumberToString:(NSString *)standardNumberStr{
    return [standardNumberStr stringByReplacingOccurrencesOfString:@"," withString:@""];
}

//获取label自适应高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
//隐藏电话号码中间4位
+ (NSString*)hideMidFourOfTelNum:(NSString*)telNum {
    if(telNum.length<11){
        return telNum;
    }
    return [NSString stringWithFormat:@"%@****%@",[telNum substringToIndex:3],[telNum substringFromIndex:7]];
}
//判断证件是否过期
+ (BOOL)checkIDCardOutTimeWithStartTime:(NSString*)startTime validityTimeInterval:(NSString*)validityInterval {
    NSString *startT = [startTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *currentTime =[[SeudPublic getCurrentTime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *Interval = [validityInterval stringByReplacingOccurrencesOfString:@"年" withString:@"0000"];
    if (startT == nil || [startT isEqualToString:@""]) {
        return NO;
    }
    if ((currentTime.integerValue - startT.integerValue) > Interval.integerValue) {//超过有效期
        return YES;
    }else {
        return NO;
    }
}
//绘制扇形图
+ (void)drawCircularSectorWithPointCenter :(CGPoint)center Radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle backGrundColor:(UIColor*)bgColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path addLineToPoint:center];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
    [path fill];
}

//数字大于0时添加+,小于0时添加-,等于0不添加符号
+ (NSString*)changeNumberStringFormatWithNumStr:(NSString*)numberStr {
    if ([numberStr isEqualToString:@"--"] ) {
        return numberStr;
    }
    numberStr = [SeudPublic standardNumberToString:numberStr];
    if ([numberStr floatValue] == 0) {
        return @"0.00";
    }
    if ([numberStr floatValue] > 0) {
        if ([numberStr containsString:@"+"]) {
            return [self rtToStandardNumberMoney:numberStr];
        }else {
            return  [NSString stringWithFormat:@"+%@", [self rtToStandardNumberMoney:numberStr]];
        }
    }
    if ([numberStr floatValue] < 0) {
        if ([numberStr containsString:@"-"]) {
            return [self rtToStandardNumberMoney:numberStr];
        }else {
            return  [NSString stringWithFormat:@"-%@", [self rtToStandardNumberMoney:numberStr]];
        }
    }
    return numberStr;
}
#pragma mark ---- 指定四个角切圆
+ (void)setLayerAndBezierPathCutCircularWithView:(UIView *)view rectCorner:(UIRectCorner)rectCorner cornerRadii:(CGSize)cornerRadii{
    // 创建BezierPath 并设置角 和 半径
    //UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    layer.frame = view.bounds;
    
    layer.path = path.CGPath;
    
    view.layer.mask = layer;
}


+ (NSAttributedString *)attributeForTextOfSpecifieldRange:(NSRange)range textColor:(UIColor *)textcolor textFont:(UIFont *)textFont otherTextColor:(UIColor *)otherTextColor otherTextFont:(UIFont *)otherTextFont initText:(NSString *)initText{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:initText];
    [str addAttribute:NSForegroundColorAttributeName value:textcolor range:range];
    [str addAttribute:NSFontAttributeName value:textFont range:range];
    
    [str addAttribute:NSForegroundColorAttributeName value:otherTextColor range:NSMakeRange(0, range.location)];
    [str addAttribute:NSFontAttributeName value:otherTextFont range:NSMakeRange(0, range.location)];
    
    [str addAttribute:NSForegroundColorAttributeName value:otherTextColor range:NSMakeRange(range.location + range.length, initText.length - range.location - range.length)];
    [str addAttribute:NSFontAttributeName value:otherTextFont range:NSMakeRange(range.location + range.length, initText.length - range.location - range.length)];
    
    return str;
}
+ (BOOL)isSameToDefaultIamge:(UIImage*)image defultImage:(UIImage*)defaultImage {
    BOOL isSame = NO;
    NSData *dData = UIImagePNGRepresentation(defaultImage);
    NSData *data = UIImagePNGRepresentation(image);
    if ([data isEqual:dData]) {
        isSame = YES;
    }
    return isSame;
}
+ (BOOL)dictIsNotNull:(NSDictionary*)dict{
    BOOL isNotNull = NO;
    if(dict&&![dict isEqual:@"<null>"]&&![dict isKindOfClass:[NSNull class]]) {
        isNotNull = YES;
    }
    return isNotNull;
}

+(NSString *)payChannelCode:(NSString *)code{
    if ([code isEqualToString:@"02"]) {
        return @"ANDROID端";
    }else if ([code isEqualToString:@"01"]){
        return @"IOS端";
    }else if ([code isEqualToString:@"00"]){
        return @"PC端";
    }
    return @"";
}
//获取中英混合字符串长度,中文英文都算一个
+  (NSInteger)convertToInt:(NSString*)strtemp {
    NSInteger chease=[SeudPublic IsChinese:strtemp];
    NSInteger engsh=strtemp.length-chease;
    return chease + engsh;
}

+(NSString*)verifyUserInput:(NSString *)content type:(EUserInputType)type{
    NSString* error = nil;
    switch (type) {
        case EUserInputTypeUserName:{
            if ( !content || content.length < 1 ){
                error = _T(@"会员姓名不能为空！", @"130003");
            }
            else if ( content.length < 2 || content.length > 6 ){
                error = _T(@"请输入正确的姓名！", @"600103");
            }
            else{
                NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
                NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
                if (![emailTest evaluateWithObject:content]) {
                    error = _T(@"请输入正确的姓名！", @"600103");
                }
            }
        }
            break;
        default:
            break;
    }
    return error;
}


+ (BOOL)isCompoundSurname:(NSString *)userName{
    BOOL surname = NO;
    if (userName.length > 2) {
        NSString *lastName = [userName substringToIndex:2];
        //81个复姓
        NSArray *allSurname = @[@"欧阳", @"太史", @"端木", @"上官", @"司马", @"东方", @"独孤", @"南宫", @"万俟", @"闻人", @"夏侯", @"诸葛", @"尉迟", @"公羊", @"赫连", @"澹台", @"皇甫", @"宗政", @"濮阳", @"公冶", @"太叔", @"申屠", @"公孙", @"慕容", @"仲孙", @"钟离", @"长孙", @"宇文", @"司徒", @"鲜于", @"司空", @"闾丘", @"子车", @"亓官", @"司寇", @"巫马", @"公西", @"颛孙", @"壤驷", @"公良", @"漆雕", @"乐正", @"宰父", @"谷梁", @"拓跋", @"夹谷", @"轩辕", @"令狐", @"段干", @"百里", @"呼延", @"东郭", @"南门", @"羊舌", @"微生", @"公户", @"公玉", @"公仪", @"梁丘", @"公仲", @"公上", @"公门", @"公山", @"公坚", @"左丘", @"公伯", @"西门", @"公祖", @"第五", @"公乘", @"贯丘", @"公皙", @"南荣", @"东里", @"东宫", @"仲长", @"子书", @"子桑", @"即墨", @"达奚", @"褚师", @"吴铭"];
        //        NSPredicate *isLastName = [NSPredicate predicateWithFormat:@"SELF == %@", lastName];
        surname = [allSurname containsObject:lastName];
        
    }
    return surname;
}
+(BOOL)isEqualImageToImage:(UIImage *)imageFornt BlowImage:(UIImage *)blow{
    NSData *data1 = UIImagePNGRepresentation(imageFornt);
    NSData *data = UIImagePNGRepresentation(blow);
    if ([data isEqual:data1]) {
        return YES;
    }
    return NO;
}

+(UIImage *)getTraderTypeString:(id)type{
     return [UIImage imageNamed:@""];/**<不取交易类型*/
    if (!type) {
        return [UIImage imageNamed:@"LX_trader0"];
    }else if ([[SeudPublic islongToString:type]integerValue]==0) {
        return [UIImage imageNamed:@"LX_trader0"];
    }else if ([[SeudPublic islongToString:type]integerValue]==1){
        return [UIImage imageNamed:@"LX_trader1"];
    }else if ([[SeudPublic islongToString:type]integerValue]==2){
        return [UIImage imageNamed:@"LX_trader2"];
    }else if ([[SeudPublic islongToString:type]integerValue]==3){
        return [UIImage imageNamed:@"LX_trader3"];
    }else if ([[SeudPublic islongToString:type]integerValue]==4){
        return [UIImage imageNamed:@"LX_trader4"];
    }else if ([[SeudPublic islongToString:type]integerValue]==5){
        return [UIImage imageNamed:@"LX_trader5"];
    }else{
        return [UIImage imageNamed:@"LX_trader0"];
    }
}
/*判断字符串是否为中文**/
+ (BOOL)isChinese:(NSString *)str
    {
        NSString *match = @"(^[\u4e00-\u9fa5]+$)";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
        return [predicate evaluateWithObject:str];
}
/*判断是不是小写字母**/
+ (BOOL)isLowerLetter:(NSString *)str
{
    if (str == nil || [str isEqualToString:@""]) {
        return NO;
    }
    if ([str characterAtIndex:0] >= 'a' && [str characterAtIndex:0] <= 'z') {
        return YES;
    }
    return NO;
    
}
/*判断是不是大写字母**/
+ (BOOL)isCatipalLetter:(NSString *)str
{
    if (str == nil || [str isEqualToString:@""]) {
        return NO;
    }
    if ([str characterAtIndex:0] >= 'A' && [str characterAtIndex:0] <= 'Z') {
        return YES;
    }
    return NO;
    
}
/*判断是否只包含中文和英文字母**/
+ (BOOL)isOnlyChineseAndEnglish:(NSString*)str {
    BOOL temp = NO;
    if ([self isChinese:str] || [self isCatipalLetter:str] || [self isLowerLetter:str]) {
        temp = YES;
    }
    return temp;
}

/**
 * 字母、数字、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *)str {
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        NSString *other = @"➋➌➍➎➏➐➑➒";
        unsigned long len=str.length;
        for(int i=0;i<len;i++)
        {
            unichar a=[str characterAtIndex:i];
            if(!((isalpha(a))
                 ||(isalnum(a))
                 ||((a=='_') || (a == '-'))
                 ||((a >= 0x4e00 && a <= 0x9fa6))
                 ||([other rangeOfString:str].location != NSNotFound)
                 ))
                return NO;
        }
        return YES;
        
    }
    return isMatch;
}
/**
 * 字母、数字、中文正则判断（包括空格）（在系统输入法中文输入时会出现拼音之间有空格，需要忽略，当按return键时会自动用字母替换，按空格输入响应汉字）
 */
+ (BOOL)isInputRuleAndBlank:(NSString *)str {
    
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d\\s]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/**
 * 纯数字
 */
+ (BOOL)isonlyIntChar:(NSString*)str {
    NSString *pattern = @"^-?[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
/**
 *  过滤字符串中的emoji
 */
+ (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
+(BOOL)isscodeTradeTime:(NSInteger)retCode isBuyer:(BOOL)bol isShowTost:(BOOL)tost{
    NSString * content =@"";
    if (retCode==4){//平台待开盘
        content=@"平台已休市";
    }else if (retCode==6){//平台已收盘
        content=@"平台已休市";
    }else if (retCode ==7){//平台未开盘
        content=@"平台未开盘";
    }else if (retCode ==5){//午间停市
        if (bol) {
            content=@"午间停市时间,无法立即买入，请进行挂单买入";
        }else{
            content=@"午间停市时间,无法立即卖出，请进行挂单卖出";
        }
    }else if (retCode ==10){//午间停市
        if (bol) {
            content=@"待开盘时间,无法立即买入，请进行挂单买入";
        }else{
            content=@"待开盘时间,无法立即卖出，请进行挂单卖出";
        }
    }else if (retCode ==1){//停市中
        content=@"平台临时停市中";
        
    }else if (retCode ==3){//紧急停市
        content=@"平台紧急停市中";
    }else if (retCode ==2){//临时停牌，交易品种停牌（停牌很久状态）
        content = @"该产品已暂停交易";
    }else if (retCode ==8){//交易品种临时停牌
        content = @"该产品已暂停交易";
    }else if (retCode ==9){//换手率达上线停牌
        content = @"该产品已暂停交易";
    }
    if(![content isEqualToString:@""]){
        if (tost) {
            [MEOHintView showHintViewWith:content];
        }
        return NO;
    }else{
        return YES;
    }

}

+(BOOL)isscodeTradeTime:(NSInteger)retCode isBuyer:(BOOL)bol{
   return [SeudPublic isscodeTradeTime:retCode isBuyer:bol isShowTost:YES];
}

+(double)doubleSavePoint:(double)dou{
    if (!dou) {
        return 0.0;
    }else{
        return [[NSString stringWithFormat:@"%.2f",dou] doubleValue];
    }
}
+ (void)addSlopeLabelInView:(UIView*)view WithString:(NSString*)str labelFont:(CGFloat)font textColor:(UIColor*)color {
    UILabel * label = [[UILabel alloc]init];
    [view addSubview:label];
    if (view.frame.size.width==0&&view.frame.size.height==0) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(@30);
            make.width.equalTo(view.mas_width);
            make.height.equalTo(@30);
        }];
    }else{
        label.frame = CGRectMake(0, (view.frame.size.height -30)*0.5, view.frame.size.width, 30);
    }
    label.backgroundColor = [UIColor clearColor];
    label.text = str;
    label.transform = CGAffineTransformMakeRotation(7*M_PI_4);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.alpha = 0.8;
    
}
/**<从导航中移除这些类名*/
+(NSArray *)removeNavagationFistClassVc:(NSString *)first SecoundVcStr:(NSString *)secVc{
    UIViewController *currentVc = [SeudPublic findTopViewController];
    NSMutableArray *arr =[[NSMutableArray alloc] initWithArray:currentVc.navigationController.viewControllers];
    for (int i= 0;i<arr.count;i++) {
        UIViewController*vc = arr[i];
        if (first&&[NSStringFromClass([vc class]) isEqualToString:first]) {
            [arr removeObjectAtIndex:i];
            if(i>0){
                i--;
            }
        }else if (secVc&&[NSStringFromClass([vc class]) isEqualToString:secVc]){
            [arr removeObjectAtIndex:i];
            if(i>0){
                i--;
            }
        }
    }
    if (arr&&arr.count<=0) {
        return @[currentVc];
    }
    return arr;
}

+ (NSString *)validTimeData:(NSString *)str{
    /********1 长期有效  2 5年有效  3  10年有效 4  20年有效*********/
    NSString *validityType=@"1";
    NSArray *validateTimeArray = @[@"5年",@"10年",@"20年",@"长期有效"];
    if ([validateTimeArray containsObject:str]) {
        NSInteger index = [validateTimeArray indexOfObject:str];
        //        NSInteger year = 0;
        switch (index) {
            case 0:{
                //                year = 5;
                validityType=@"2";
            }
                break;
            case 1:{
                //                year = 10;
                validityType=@"3";
            }
                break;
            case 2:{
                //                year = 20;
                validityType=@"4";
            }
                break;
            default:
                break;
        }
    }
    return validityType;
}
+ (NSString*)addSpecialSymbolInTheMiddleOfString:(NSString*)str symbolNum:(NSInteger)num frontLegth:(NSInteger)fNum backLength:(NSInteger)bNum{
    if (!str || [str isEqualToString:@""]) {
        return str;
    }
    NSString *frontStr = [str substringToIndex:fNum];
    NSString *backStr = [str substringFromIndex:(str.length -bNum)];
    NSMutableString *midStr = [[NSMutableString alloc]init];
    for (int i = 0; i < num; i ++) {
        [midStr appendString:@"*"];
    }
    return [NSString stringWithFormat:@"%@%@%@",frontStr,midStr,backStr];
}
@end
