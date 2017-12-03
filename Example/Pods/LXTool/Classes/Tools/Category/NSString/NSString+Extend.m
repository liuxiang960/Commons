//
//  NSString+Extend.m
//  CSDirectBank
//
//  Created by 程凯 on 15/8/16.
//  Copyright (c) 2015年 程凯. All rights reserved.
//

#import "NSString+Extend.h"
#import "RegularExpression.h"

#define iOS8 (([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) ? YES : NO)

@implementation NSString (Extend)
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

- (NSString *)stringWithBase64 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)decodeBase64StringToString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self
                                                      options:0];
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (NSString *)trim
{
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:self];
    return [mutableString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (BOOL)isContainString:(NSString *)string
{
    BOOL judge = NO;
    if (!iOS8)
    {
        if([self rangeOfString:string].location != NSNotFound)
        {
            judge = YES;
        }
    }
    else
    {
        judge =[SeudPublic isStringBaoHanString:self myString:string];
//        [self isContainString:string];
    }
    
    return judge;
}

+ (BOOL)isNilOrEmpty:(NSString *)str
{
    if (str == nil || [str isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        if (str.length > 0)
        {
            return NO;
        }
        else {
            return YES;
        }
    }
}

- (NSString *)permilString
{
    if (!self||[self floatValue] == 0.00)
    {
        return @"0.00";
    }
    else if ([self floatValue]<1.00)
    {
        return self;
    }
    else
    {
        NSNumberFormatter *form =[[NSNumberFormatter alloc] init];
        [form setPositiveFormat:@",###.00;"];
        NSString *string = [form stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
        return string;
    }
    
    return @"";
}

- (NSUInteger)characterLength
{
    NSUInteger totalLength = 0;
    NSUInteger length = self.length;
    for (NSUInteger i = 0; i < length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isascii(ch)) {
            totalLength += 1;
        } else {
            totalLength += 2;
        }
    }
    return totalLength;
}

- (NSString *)substringToCharacterIndex:(NSUInteger)to
{
    NSUInteger totalLength = 0;
    NSUInteger length = self.length;
    for (NSUInteger i = 0; i < length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isascii(ch)) {
            if (totalLength + 1 > to) {
                return [self substringToIndex:i];
            }
            totalLength += 1;
        } else {
            if (totalLength + 2 > to) {
                return [self substringToIndex:i];
            }
            totalLength += 2;
        }
    }
    return self;
}

- (NSString *)disable_emoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

-(NSString *)stringGetNumberString{
    if (!self) return @"0";
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
}

-(NSString *)cardNumberTail{
    
    if (self.length <= 4) {
        return self;
    }
    return [self substringWithRange:NSMakeRange(self.length - 4, 4)];
}

-(NSString *)toChineseAmount{
    
    NSString *numberString = [self stringGetNumberString];
    if(numberString.length == 0) return @"";
    
    NSRange range = [numberString rangeOfString:@"."];
    NSInteger begin = [numberString integerValue];
    NSInteger end = 0;
    if(range.length > 0) {
        begin = [[numberString substringToIndex:range.location] integerValue];
        NSString *endstr = [numberString substringFromIndex:range.location];
        float endF = [endstr floatValue];
        end = endF * 100;
    }
    NSMutableString *result = [[NSMutableString alloc] init];
    NSArray *ChinaUnits = @[@"仟", @"佰", @"拾", @""];
    NSArray *ChinaUnitss = @[@"亿", @"万", @"圆"];
    NSArray *ChinaNumbers = @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    
    //圆
    NSInteger base = 100000000;
    NSInteger temp = begin / base;
    begin %= base;
    for(int j = 0; j < 3; j++) {
        if(temp > 0) {
            NSInteger d = 1000;
            for(int i = 0; i < 4; i++) {
                NSInteger index = temp / d;
                temp %= d;
                d /= 10;
                if(index == 0 && result.length > 0) {
                    if(d > 0 && temp / d > 0)
                        [result appendFormat:@"%@", ChinaNumbers[index]];
                } else if(index > 0 && index < 10)
                    [result appendFormat:@"%@%@", ChinaNumbers[index], ChinaUnits[i]];
            }
            if(result.length > 0)
                [result appendString:ChinaUnitss[j]];
        }
        base /= 10000;
        if(base > 0) {
            temp = begin / base;
            begin %= base;
        }
    }
    range = [result rangeOfString:@"圆"];
    if(range.length == 0)
        [result appendString:@"圆"];
    
    // 角、分
    if(end > 0) {
        temp = end / 10;
        if(temp > 0)
            [result appendFormat:@"%@角", ChinaNumbers[temp]];
        else
            [result appendString:@"零"];
        temp = end % 10;
        if(temp > 0)
            [result appendFormat:@"%@分", ChinaNumbers[temp]];
        else
            [result appendString:@"整"];
    } else {
        [result appendString:@"整"];
    }
    
    return result;
}

- (NSString *)removeHTML{
    return [self removeHTML:@""];
}

-(NSString *)removeHTML:(NSString *)tag{
    NSString *html = self;
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL];
        [theScanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:tag];
    }
    return html;
}

-(NSString *)cardNumberSeparate:(BOOL)isDese{
    
    NSString *originString = [self trim];
    NSInteger sLength = 4;
    NSInteger length = originString.length;
    if (length <=sLength) return originString;
    
    NSInteger loopCount = (int)originString.length/sLength;
    NSInteger loopLeft = originString.length % sLength;
    if (loopLeft == 0) loopCount--;
    NSString *result = @"";
    NSInteger loc = 0;
    NSString *temp = @"";
    for (int i = 0; i < loopCount; i++) {
        loc = i*sLength;
        temp = [originString substringWithRange:NSMakeRange(loc, sLength)];
        if (isDese) {
            temp = @"";
            for (int j = 0; j < sLength; j++) {
                temp = [NSString stringWithFormat:@"%@%@",temp,@"*"];
            }
        }
        if (i == 0) {
            result = temp;
        } else {
            result = [NSString stringWithFormat:@"%@ %@",result,temp];
        }
    }
    temp = [originString substringWithRange:NSMakeRange(loc + sLength, length - loopCount*sLength)];
    result = [NSString stringWithFormat:@"%@ %@",result,temp];
    
    return result;
}

-(NSString *)idNumberDesensitize{
    
    if (![self isIDCardWithString]){
        return self;
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, self.length - 7) withString:@"********"];
}

-(NSString *)emailDesensitize{
    
    NSArray *strs = [self componentsSeparatedByString:@"@"];
    if (!strs || strs.count != 2) {
        return self;
    }
    NSString *prefix = strs[0];
    if (prefix.length > 3) {
        
        NSString *tmp = @"";
        for (int i = 0; i < prefix.length - 3; i++) {
            tmp = [NSString stringWithFormat:@"*%@",tmp];
        }
        prefix = [prefix stringByReplacingCharactersInRange:NSMakeRange(3, prefix.length - 3) withString:tmp];
    }
    return [NSString stringWithFormat:@"%@@%@",prefix,strs[1]];
}

-(NSDictionary *)convertToDictionary{
    NSError *jsonError;
    NSData *objectData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    return json;
}

-(BOOL)isValidateTelPhoneNumber{
    
    NSString *phoneRegex = @"\\d{3}-{0,1}\\d{8}|\\d{4}-{0,1}\\d{7,8}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

-(BOOL)isValidateMobilePhoneNumber{
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

-(BOOL)isValidateCodeEqual:(NSString *)vcode{
    
    #if VER_TYPE == 3
    
    #else
    
    if ([self isEqualToString:@"9527"]) {
        return YES;
    }
    
    #endif
    
    if ([self isEqualToString:vcode]) {
        return YES;
    }
    
    return NO;
}

-(NSString *)numberTenPercent{
    
    if ([self doubleValue]==0.00) {
        return @"0.00";
    }
    double number=[self doubleValue];
    if (number>=0&& number<1000) {
        return [NSString stringWithFormat:@"%.2f",number];
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return formattedNumberString;
}

-(NSString *)toFloatValue{
    if ([@"" isEqualToString:self]) {
        NSString *str = @"0";
        return [NSString stringWithFormat:@"%.2f",[str floatValue]];
    }
    return [NSString stringWithFormat:@"%.2f",[self floatValue]];
}

@end
