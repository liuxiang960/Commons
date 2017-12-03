//
//  NSString.h
//  SEUDApp
//
//  Created by Chengkai on 16/8/29.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

/**
 *  @author 程凯, 16-08-29 15:08:01
 *
 *  AES加密
 *
 *  @return 加密后的字符串
 *
 *  @since 1.0
 */
-(NSString *)stringByAESEncrypt;

///**
// *  @author 程凯, 16-08-29 15:08:42
// *
// *  AES解密
// *
// *  @return 解密后的字符串
// *
// *  @since 1.0
// */
//-(NSString *)stringByAESDecrypt;

/*!
 *  @author 刘湘, 17-08-23 11:08:14
 *
 *  @brief 手机号码加密显示
 *
 *  @return 188****9191
 *
 *  @since <#1.1.1#>
 */
-(NSString *)stringByPhoneNumberAESEncrypt;
@end
