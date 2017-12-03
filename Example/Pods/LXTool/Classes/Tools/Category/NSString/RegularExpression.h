//
//  RegularExpression.h
//  CSDirectBank
//
//  Created by 程凯 on 15/9/2.
//  Copyright (c) 2015年 程凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularExpression)
- (BOOL)isIDCardWithString;
- (BOOL)isMatchAge;/**< 是否处于年龄范围内: 18岁 ~ 65岁 */
- (BOOL)isPhoneNumberString;
- (BOOL)isMoneyNumberString;
- (BOOL)isValideMoneyString;/**<是否为正确的金额*/
- (BOOL)isCardNumberString;
- (BOOL)isAlphabetAndNumber;
- (BOOL)isPureAlphabet;
- (BOOL)isPureNumber;
-(NSString *)getPhoneCompany;
- (BOOL)isValidateEmail;/**<判断一个字符创是否为合法邮箱地址*/
@end