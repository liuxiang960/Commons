//
//  RegularExpression.m
//  CSDirectBank
//
//  Created by 程凯 on 15/9/2.
//  Copyright (c) 2015年 程凯. All rights reserved.
//

#import "RegularExpression.h"

@implementation NSString (RegularExpression)

- (BOOL)isIDCardWithString
{    
    if (self.length <= 0)
    {
        return NO;
    }
    
    NSString *isIDCard = @"\\d{17}[\\d|X|x]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isIDCard];
    return [predicate evaluateWithObject:self];
}

-(BOOL)isMatchAge
{
    if (self.length ==18) {
        NSString *numStr =[self substringWithRange:NSMakeRange(6, 8)];
        NSString  *litterAgeStr =[NSString stringWithFormat:@"%zd",[numStr integerValue]+180000];
        NSString *largeAgeStr =[NSString stringWithFormat:@"%zd",[numStr integerValue]+650000];
       
        NSDate *currentDate =[NSDate date];
        NSDateFormatter *formate =[[NSDateFormatter alloc]init];
        [formate setDateFormat:@"yyyyMMdd"];
        [formate setLocale:[NSLocale currentLocale]];
        NSString *currentStr =[formate stringFromDate:currentDate];
        if ([currentStr compare:largeAgeStr] !=NSOrderedDescending && [currentStr compare:litterAgeStr] !=NSOrderedAscending){
            return YES;
        }
    }
    return NO;
}
- (BOOL)isPhoneNumberString
{
    if (self.length <= 0)
    {
        return NO;
    }
    
    //电话号码正则
    NSString *isPhoneNumber = @"1[0-9]{10}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isPhoneNumber];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isMoneyNumberString
{
    if (self.length <= 0)
    {
        return NO;
    }
    
    NSString *isMoneyNumber = @"[0-9]+(.[0-9]{1,2})?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isMoneyNumber];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValideMoneyString
{
    NSString *regex = @"^\\d{1,7}+|\\d{1,7}+(\\.\\d{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

- (BOOL)isCardNumberString
{
    if (self.length <= 0)
    {
        return NO;
    }
    
    NSString *isCardNumber = @"[0-9]{14,21}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isCardNumber];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isAlphabetAndNumber
{
    if (self.length <= 0)
    {
        return NO;
    }
    
    NSString *regex = @"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isPureAlphabet
{
    if (self.length <= 0)
    {
        return NO;
    }
    
    NSString *regex = @"[a-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isPureNumber
{
    if (self.length <= 0)
    {
        return NO;
    }
    
    NSString *regex = @"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

-(NSString *)getPhoneCompany
{
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *company = nil;
    /*
     * 中国移动：134、135、136、137、138、139、150、151、152、157(TD)、158、159、182、183、184、187、178、188、147（数据卡号段） 、1705（虚拟运营商移动号段）
     */
    NSString * CM = @"^1(34[0-8]|705|(3[5-9]|5[0217-9]|8[247]|7[8])\\d)\\d{7}$";
    
    
    /*
     * 中国联通：130、131、132、145(数据卡号段)155、156、176、185、186、1709（虚拟运营商联通号段）
     */
    NSString * CU = @"^1(709|(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d)\\d{7}$";
    
    /*
     * 中国电信：133、153、177、180、181、189、（1349卫通）、1700（虚拟运营商电信号段）
     */
    NSString * CT = @"^1((33|53|77|70|8[019])[0-9]|349)\\d{7}$";
    
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestcm evaluateWithObject:temp] == YES) {
        company = @"中国移动";
    }
    else if ([regextestcu evaluateWithObject:temp] == YES)
    {
        company = @"中国联通";
    }
    else if([regextestct evaluateWithObject:temp] == YES)
    {
        company = @"中国电信";
    }
    else
    {
        company = @"未知类型";
    }
    
    return company;
}

- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES % @", emailRegex];
    return [predicate evaluateWithObject:self];
}

@end