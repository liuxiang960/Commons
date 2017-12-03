//
//  NSString+RE.h
//  SEUDApp
//
//  Created by chuangwuxian on 17/7/27.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RE)
/**组织机构代码正则*/
- (BOOL)isOrganNum;
/**统一社会信用代码正则*/
- (BOOL)isUniqueSocialNum;
/**身份证判断年龄是否在18-65之间*/
-(BOOL)isMatchAge;
/**营业执照号码正则*/
- (BOOL)isBusinessNum;
@end
