//
//  UILabel+CustomSpace.h
//  SEUDApp
//
//  Created by chuangwuxian on 17/1/23.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CustomSpace)
/*!
 *  @author 杜鹏, 17-1-22 15:11:11
 *
 *  @brief 改变label 行间距
 *
 *  @since <#1.0.2#>
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
/*!
 *  @author 杜鹏, 16-1-22 15:11:11
 *
 *  @brief 改变label 字间距
 *
 *  @since <#1.0.2#>
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/*!
 *  @author 杜鹏, 16-11-22 15:11:11
 *
 *  @brief 改变label 行间距,字间距和左缩进
 *
 *  @since <#1.0.2#>
 */

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace headIndent:(float) headIndent;
/*!
 *  @author 杜鹏, 16-11-22 15:11:11
 *
 *  @brief 改变label 行间距,字间距
 *
 *  @since <#1.0.2#>
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
/*!
 *  @author 杜鹏, 16-11-22 15:11:11
 *
 *  @brief 计算给定文字的高度
 *
 *  @since <#1.0.2#>
 */
+ (CGFloat)labelHeightWithTitle:(NSString*)title width:(CGFloat)width customWordLine:(CGFloat)customLineSpace customWordSpace:(CGFloat)customWordSpace font:(UIFont *)font;

+ (CGFloat)labelHeightWithTitle:(NSString*)title width:(CGFloat)width customWordLine:(CGFloat)customLineSpace customWordSpace:(CGFloat)customWordSpace font:(UIFont *)font numberOfLines:(NSInteger)nunber;

+ (CGFloat)labelHeightWithTitle:(NSString*)title width:(CGFloat)width customWordLine:(CGFloat)customLineSpace customWordSpace:(CGFloat)customWordSpace font:(UIFont *)font numberOfLines:(NSInteger)nunber headIndent:(float) headIndent;
@end
