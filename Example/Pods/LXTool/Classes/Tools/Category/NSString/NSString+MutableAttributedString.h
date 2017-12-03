//
//  NSString+MutableAttributedString.h
//  SEUDApp
//
//  Created by chuangwuxian on 17/1/23.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MutableAttributedString)
/*!
 *  @author 杜鹏, 17-1-24 15:11:11
 *
 *  @brief 富文本字符串(传入一个字符串)
 *  @param string        传入字符串
 *  @param fColor       前面字符串的颜色
 *  @param fSize         前面字符串的字体大小
 *  @param fSpace      前面字符串的字间距
 *  @param bLength     后面字符串的个数
 *  @param bColor       后面字符串颜色
 *  @param bSize         后面字符串字体大小
 *  @param bSpace      后面字符串字间距
 *  @since <#1.0.2#>
 */
+ (NSAttributedString*)attributedStringWithString:(NSString*)string frontStringColor:(UIColor*)fColor frontStringSize:(CGFloat)fSize frontStringWordSpace:(CGFloat)fSpace BackStringLength:(NSInteger)bLength backStringColor:(UIColor*)bColor backStringSize:(CGFloat)bSize backStringWordSpace:(CGFloat)bSpace;
/*!
 *  @author 杜鹏, 17-1-24 15:11:11
 *
 *  @brief 富文本字符串(传入两个字符串拼接)
 *  @param fString      前面字符串
 *  @param fColor       前面字符串的颜色
 *  @param fSize         前面字符串的字体大小
 *  @param fSpace      前面字符串的字间距
 *  @param bString      后面字符串
 *  @param bColor       后面字符串颜色
 *  @param bSize         后面字符串字体大小
 *  @param bSpace      后面字符串字间距
 *  @since <#1.0.2#>
 */
+ (NSAttributedString*)attributedStringWithFrontString:(NSString*)fString frontStringColor:(UIColor*)fColor frontStringSize:(CGFloat)fSize frontStringWordSpace:(CGFloat)fSpace backString:(NSString*)bString backStringColor:(UIColor*)bColor backStringSize:(CGFloat)bSize backStringWordSpace:(CGFloat)bSpace;

/*!
 *  @author 杜鹏, 17-1-24 15:11:11
 *
 *  @brief 富文本字符串(图文混排)
 *  @param string                   字符串
 *  @param color                    字体颜色
 *  @param font                     字体大小
 *  @param space                  文字间距
 *  @param image                   图片
 *  @param imageBounds        图片bounds
 *  @param index                    图片位置
 *  @since <#1.0.2#>
 */
+ (NSAttributedString*)attributedStringWithString:(NSString*)string stringColor:(UIColor*)color stringFont:(CGFloat)font stringSpace:(CGFloat)space image:(UIImage*)image imageBounds:(CGRect)imageBounds imageIndex:(NSInteger)index;

/*!
 *  @author 杜鹏, 17-1-24 15:11:11
 *
 *  @brief 富文本字符串(图文混排)
 *  @param string                   字符串
 *  @param color                    字体颜色
 *  @param font                     字体大小
 *  @param image                   图片
 *  @param imageBounds        图片bounds
 *  @param type                    类型(0:图片在前,否则图片在最后面)
 *  @since <#1.0.2#>
 */
+ (NSAttributedString*)attributedStringWithString:(NSString*)string stringColor:(UIColor*)color stringFont:(CGFloat)font image:(UIImage*)image imageBounds:(CGRect)bounds imageType:(NSInteger)type;
@end
