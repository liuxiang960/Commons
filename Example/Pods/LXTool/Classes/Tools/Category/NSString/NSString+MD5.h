//
//  NSString+MD5.h
//  broodon
//
//  Created by fengxiaofeng on 15/12/23.
//  Copyright © 2015年 fengxiaofeng. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSString *)MD5Base64String;

@end