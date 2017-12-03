//
//  UILabel+DrawLine.m
//  SEUDApp
//
//  Created by 刘湘 on 17/3/9.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import "UILabel+DrawLine.h"

@implementation UILabel (DrawLine)
-(void)setContent:(NSString *)content DrawlineLoction:(NSInteger)location{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    [str addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0,content.length)];
//    [str addAttribute:NSForegroundColorAttributeName value:self.font range:NSMakeRange(0,content.length)];
    if (location==0) {
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:content attributes:attribtDic];
        self.attributedText = attribtStr;
        return;
    }else if (location==1){
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 1)];
    }else{
         [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, content.length)];
    }
    self.attributedText=str;
}
@end
