//
//  NSString+RE.m
//  SEUDApp
//
//  Created by chuangwuxian on 17/7/27.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import "NSString+RE.h"

@implementation NSString (RE)
- (BOOL)isOrganNum {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[-a-zA-Z0-9]{10}$"];
    return [predicate evaluateWithObject:self];
}
- (BOOL)isUniqueSocialNum {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9a-zA-Z]{18}$"];
    return [predicate evaluateWithObject:self];
}
-(BOOL)isMatchAge
{
    if (self.length ==18) {
        NSString *numStr =[self substringWithRange:NSMakeRange(6, 8)];
        NSString  *litterAgeStr =[NSString stringWithFormat:@"%zd",[numStr integerValue]+160000];
        NSString *largeAgeStr =[NSString stringWithFormat:@"%zd",[numStr integerValue]+700000];
        
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
- (BOOL)isBusinessNum {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0-9a-zA-Z_]{15}$"];
    return [predicate evaluateWithObject:self];
}
@end
