//
//  NSString+Extend.h
//  CSDirectBank
//
//  Created by 程凯 on 15/8/16.
//  Copyright (c) 2015年 程凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)
/*!
 *  @author 程凯, 15-08-07 09:08:32
 *
 *  @brief  兼容ios7以上版本该方法，消除警告
 *
 *  @param font          字体样式
 *  @param size          原本大小
 *  @param lineBreakMode 文字排放样式
 *
 *  @return 得到字体大小
 *
 *  @since 2.8.0
 */
- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
         lineBreakMode:(NSLineBreakMode)lineBreakMode;

/*!
 *  @author 程凯, 15-08-07 09:08:39
 *
 *  @brief  利用系统自带base64编码
 *
 *  @return 编码后的字符串
 *
 *  @since 2.8.0
 */
- (NSString *)stringWithBase64;

/*!
 *  @author 程凯, 15-09-17 17:09:41
 *
 *  @brief  将编码的base64字符串解码
 *
 *  @return 解码后的字符串
 *
 *  @since 2.8.0
 */
- (NSString *)decodeBase64StringToString;

/*!
 *  @author 程凯, 15-08-24 00:08:33
 *
 *  @brief  通过字体属性来计算文字高度
 *
 *  @param attrs 字体属性设置
 *  @param size  需要加载字体的控件大小
 *
 *  @return 字体所占区域大小
 *
 *  @since 3.0.1
 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size;

/*!
 *  @author 郑新民, 15-08-25 18:08:22
 *
 *  @brief  去除空格
 *
 *  @param input 需要去除空格的字符串
 *
 *  @return 已去除空格的字符串
 *
 *  @since 3.0.1
 */
- (NSString *)trim;

/*!
 *  @author 程凯, 15-08-26 21:08:54
 *
 *  @brief  [推荐] 判断字符串里面是否包含某个字符，兼容iOS8之前的系统
 *
 *  @return 是否包含
 *
 *  @since 3.0.1
 */
- (BOOL)isContainString:(NSString *)string;

/*!
 *  @author 程凯, 15-12-25 17:12:19
 *
 *  @brief 判断字体是否为空
 *
 *  @return 布尔值
 *
 *  @since 3.2
 */
+ (BOOL)isNilOrEmpty:(NSString *)str;

/*!
 *  @author 朱介伟, 16-01-21 18:01:54
 *
 *  @brief  将金额转为千分制显示
 *
 *  @return 结果
 *
 *  @since 3.3
 */
- (NSString *)permilString;

/*!
 *  @author jojo, 16-01-21 22:01:04
 *
 *  @brief 计算字符串字符个数（非ascii字符算2个字符）
 *
 *  @return 字符个数
 *
 *  @since 3.3
 */
- (NSUInteger)characterLength;

/*!
 *  @author jojo, 16-01-22 13:01:18
 *
 *  @brief 截取前to个字符
 *
 *  @param to 要截取的字符个数（非ascii字符算2个字符）
 *
 *  @return 截取后的字符串
 *
 *  @since 3.3
 */
- (NSString *)substringToCharacterIndex:(NSUInteger)to;

/*!
 *  @author 郑新民, 18-02-29 18:45:22
 *
 *  @brief  去除表情符号
 *
 *  @return 已去除表情的字符串
 *
 *  @since 3.4
 *
 */
- (NSString *)disable_emoji;

/**
 *  去掉非数字字符
 *
 *  @return 数字字符串
 */
-(NSString *)stringGetNumberString;

/**
 *  @author 程凯, 16-07-12 16:07:06
 *
 *  获取银行卡号尾号(后四位)
 *
 *  @return 后四位
 *
 *  @since
 */
-(NSString *)cardNumberTail;

/**
 *  @author 程凯, 16-07-19 18:07:31
 *
 *  把卡号4位一段分隔，分隔符空格
 *
 *  @param isDese 是否需要脱敏(尾号不会脱敏)
 *
 *  @return
 *
 *  @since 1.0
 */
-(NSString *)cardNumberSeparate:(BOOL)isDese;

/**
 *  @author 程凯, 16-08-01 23:08:41
 *
 *  身份证号码脱敏
 *
 *  @return 脱敏后的字符串
 *
 *  @since 1.0
 */
-(NSString *)idNumberDesensitize;

/**
 *  @author 程凯, 16-08-19 15:08:18
 *
 *  邮箱账号脱敏
 *
 *  @return 脱敏后邮箱账号
 *
 *  @since 1.0
 */
-(NSString *)emailDesensitize;

/**
 *  @author 程凯, 16-07-12 16:07:59
 *
 *  金额转中文大写
 *
 *  @return
 *
 *  @since 1.0
 */
-(NSString *)toChineseAmount;

/**
 *  @author 程凯, 16-07-15 16:07:06
 *
 *  去掉字符串中的Html内容
 *
 *  @param html
 *
 *  @return
 *
 *  @since 1.0
 */
-(NSString *)removeHTML;

/**
 *  @author 程凯, 16-07-15 17:07:32
 *
 *  去掉字符创中的Html内容，并用tag替换掉html标签。如tag=@"#"： <a>创无限</a> 替换之后 :  #创无限#
 *
 *  @param tag 替换Tag
 *
 *  @return
 *
 *  @since 1.0
 */
-(NSString *)removeHTML:(NSString *)tag;

/**
 *  @author 程凯, 16-08-03 12:08:09
 *
 *  json字符串转字典
 *
 *  @return
 *
 *  @since 1.0
 */
-(NSDictionary *)convertToDictionary;

/**
 *  @author 程凯, 16-08-11 15:08:29
 *
 *  是否为有效的座机号码
 *
 *  @return YES:有效座机号 NO:无效座机号
 *
 *  @since 1.0
 */
-(BOOL)isValidateTelPhoneNumber;

/**
 *  @author 程凯, 16-08-11 15:08:49
 *
 *  是否为有效的手机号码
 *
 *  @return YES:有效手机号 NO:无效手机号
 *
 *  @since 1.0
 */
-(BOOL)isValidateMobilePhoneNumber;

/**
 *  @author 程凯, 16-08-22 14:08:55
 *
 *  判断两个校验码是否相等
 *
 *  @param vcode 正确校验码的值
 *
 *  @since 1.0
 */
-(BOOL)isValidateCodeEqual:(NSString *)vcode;

/**
 *  @author 程凯, 16-08-23 11:08:18
 *
 *  格式化数值: 千分位显示
 *
 *  @return 格式化之后的字符串
 *
 *  @since 1.0
 */
-(NSString *)numberTenPercent;

/**
 *  @author 程凯, 16-09-08 18:09:32
 *
 *  格式化成保留小数位的数字字符串,小数点保留两位
 *
 *  @return 格式化之后的字符串
 *
 *  @since 1.0
 */
-(NSString *)toFloatValue;

@end
