//
//  UILabel+CustomSpace.m
//  SEUDApp
//
//  Created by chuangwuxian on 17/1/23.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import "UILabel+CustomSpace.h"

@implementation UILabel (CustomSpace)
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
+ (CGFloat)labelHeightWithTitle:(NSString*)title width:(CGFloat)width customWordLine:(CGFloat)customLineSpace customWordSpace:(CGFloat)customWordSpace font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [self changeSpaceForLabel:label withLineSpace:customLineSpace WordSpace:customWordSpace];
    CGFloat height = label.frame.size.height;
    return height;
}
+ (CGFloat)labelHeightWithTitle:(NSString*)title width:(CGFloat)width customWordLine:(CGFloat)customLineSpace customWordSpace:(CGFloat)customWordSpace font:(UIFont *)font numberOfLines:(NSInteger)nunber {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = nunber;
    [self changeSpaceForLabel:label withLineSpace:customLineSpace WordSpace:customWordSpace];
    CGFloat height = label.frame.size.height;
    return height;
}
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace headIndent:(float) headIndent{
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [paragraphStyle setHeadIndent:headIndent];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
+ (CGFloat)labelHeightWithTitle:(NSString*)title width:(CGFloat)width customWordLine:(CGFloat)customLineSpace customWordSpace:(CGFloat)customWordSpace font:(UIFont *)font numberOfLines:(NSInteger)nunber headIndent:(float) headIndent{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = nunber;
    [self changeSpaceForLabel:label withLineSpace:customLineSpace WordSpace:customWordSpace headIndent:headIndent];
    CGFloat height = label.frame.size.height;
    return height;
}
@end
