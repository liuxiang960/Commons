//
//  NSString+MutableAttributedString.m
//  SEUDApp
//
//  Created by chuangwuxian on 17/1/23.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import "NSString+MutableAttributedString.h"

@implementation NSString (MutableAttributedString)
+ (NSAttributedString*)attributedStringWithString:(NSString*)string frontStringColor:(UIColor*)fColor frontStringSize:(CGFloat)fSize frontStringWordSpace:(CGFloat)fSpace BackStringLength:(NSInteger)bLength backStringColor:(UIColor*)bColor backStringSize:(CGFloat)bSize backStringWordSpace:(CGFloat)bSpace{
    if (string == nil) {
        return [[NSMutableAttributedString alloc]initWithString:@""];
    }
    if (string.length < bLength) {
        return [[NSMutableAttributedString alloc]initWithString:@""];
    }
    //前面string
    NSString *fStr = [string substringWithRange:NSMakeRange(0, string.length - bLength)];
    NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc]initWithString:fStr];
    [attributedStr1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:bSize] range:NSMakeRange(0, fStr.length)];
    [attributedStr1 addAttribute:NSForegroundColorAttributeName value:fColor range:NSMakeRange(0, fStr.length)];
    [attributedStr1 addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:fSpace] range:NSMakeRange(0, fStr.length)];
    
    //后面string
    NSString *bStr = [string substringWithRange:NSMakeRange(fStr.length, bLength)];
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc]initWithString:bStr];
    [attributedStr2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:bSize] range:NSMakeRange(0, bStr.length)];
    [attributedStr2 addAttribute:NSForegroundColorAttributeName value:bColor range:NSMakeRange(0, bStr.length)];
    [attributedStr2 addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:bSpace] range:NSMakeRange(0, bStr.length)];
    
    [attributedStr1 appendAttributedString:attributedStr2];
    return attributedStr1;
}
+ (NSAttributedString*)attributedStringWithFrontString:(NSString*)fString frontStringColor:(UIColor*)fColor frontStringSize:(CGFloat)fSize frontStringWordSpace:(CGFloat)fSpace backString:(NSString*)bString backStringColor:(UIColor*)bColor backStringSize:(CGFloat)bSize backStringWordSpace:(CGFloat)bSpace {
    if (fString == nil) {
        fString = @"";
    }
    if (bString == nil) {
        bString = @"";
    }
    NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc]initWithString:fString];
    [attributedStr1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:fSize] range:NSMakeRange(0, fString.length)];
    [attributedStr1 addAttribute:NSForegroundColorAttributeName value:fColor range:NSMakeRange(0, fString.length)];
    [attributedStr1 addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:fSpace] range:NSMakeRange(0, fString.length)];
    //后面string
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc]initWithString:bString];
    [attributedStr2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:bSize] range:NSMakeRange(0, bString.length)];
    [attributedStr2 addAttribute:NSForegroundColorAttributeName value:bColor range:NSMakeRange(0, bString.length)];
    [attributedStr2 addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:bSpace] range:NSMakeRange(0, bString.length)];
    [attributedStr1 appendAttributedString:attributedStr2];
    return attributedStr1;

}
+ (NSAttributedString*)attributedStringWithString:(NSString*)string stringColor:(UIColor*)color stringFont:(CGFloat)font stringSpace:(CGFloat)space image:(UIImage*)image imageBounds:(CGRect)bounds imageIndex:(NSInteger)index {
    if (string == nil) {
        string = @"";
    }
    if (index > string.length) {
        index = string.length;
    }
    //计算当前字体高度
//        CGFloat height =[string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size.height;
//    CGFloat temp = (bounds.size.height - height);
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, string.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    [attributedStr addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:space] range:NSMakeRange(0, string.length)];
//        [attributedStr addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:temp] range:NSMakeRange(0, string.length)];
    NSTextAttachment *attatch = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
    attatch.bounds = bounds;
    attatch.image = image;
    [attributedStr insertAttributedString:[NSMutableAttributedString attributedStringWithAttachment:attatch] atIndex:index];
    return attributedStr;
}
+ (NSAttributedString*)attributedStringWithString:(NSString*)string stringColor:(UIColor*)color stringFont:(CGFloat)font image:(UIImage*)image imageBounds:(CGRect)bounds imageType:(NSInteger)type{
    if (string == nil) string = @"";
    NSInteger index = type == 0 ? 0 : string.length;
    return [self attributedStringWithString:string stringColor:color stringFont:font stringSpace:0 image:image imageBounds:bounds imageIndex:index];
}
@end
