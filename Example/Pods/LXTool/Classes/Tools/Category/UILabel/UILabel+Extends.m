//
//  UILabel.m
//  SEUDApp
//
//  Created by 刘湘 on 16/12/8.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "UILabel+Extends.h"

@implementation UILabel (Extends)

-(void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing{
    if (!text) return;
    
    UIColor *tmpColor = self.textColor;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    [attrString addAttribute:NSForegroundColorAttributeName value:tmpColor range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;//行距
    [style setAlignment:self.textAlignment];/**< 文本对齐方式 */
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    self.attributedText = attrString;
}

@end
