//
//  UILabel+AlignmentTop.m
//  SEUDApp
//
//  Created by 自制力 on 17/2/5.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import "UILabel+AlignmentTop.h"

@implementation UILabel (AlignmentTop)
- (void)setTextAlignmentTop{
    CGSize fontSize = [self.text sizeWithFont:self.font];
    self.numberOfLines = fontSize.width / self.frame.size.width + 1;
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;

    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (self.frame.size.height - theStringSize.height) / fontSize.height;
    self.numberOfLines = 0;
    for(int i = 0; i < newLinesToPad; i++){
        self.text = [self.text stringByAppendingString:@"\n"];
    }
}



@end
