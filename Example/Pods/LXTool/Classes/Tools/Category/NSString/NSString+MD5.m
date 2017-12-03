//
//  NSString+MD5.m
//  broodon
//
//  Created by fengxiaofeng on 15/12/23.
//  Copyright © 2015年 fengxiaofeng. All rights reserved.
//

#import "NSString+MD5.h"
#import <Foundation/Foundation.h>
#import "GTMBase64.h"

@implementation NSString (MD5)

- (NSString *)MD5Base64String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([[self dataUsingEncoding:NSUTF8StringEncoding] bytes], [self length], result);
    NSData *data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    data = [GTMBase64 encodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

@end