//
//  UIColor+helper.h
//  Kline
//
//  Created by zhaomingxi on 14-2-9.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class colorModel;
@interface UIColor (helper)

+ (UIColor *) colorWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;
+ (colorModel *) RGBWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;
+ (NSMutableAttributedString *)string:(NSString *)content ByOtherColor:(NSString *)hexColor andIndex:(int)index andLength:(int)length;

/**
 *  @author 程凯, 16-07-06 09:07:42
 *
 *  色值转换，alpha默认为1.0
 *
 *  @param color 十六进制的RGB色值
 *
 *  @return
 *
 *  @since 1.0
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

+(UIColor *)randomColor;/**< 随机颜色 */

@end
