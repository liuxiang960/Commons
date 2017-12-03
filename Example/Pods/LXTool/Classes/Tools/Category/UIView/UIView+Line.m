//
//  UIView+Line.m
//  SEUDApp
//
//  Created by 刘湘 on 17/4/19.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (Line)

-(void)DrawLineLocate:(DrawLocate)locat Corlor:(UIColor*)colr LineWidth:(CGFloat)lineWight{
    UIView *vi=[self CreateLineViewColor:colr];
    [self addSubview:vi];
    if (locat==DradwTopLine) {
       [vi mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(@0);
           make.left.equalTo(@0.5);
           make.width.equalTo(self.mas_width);
           make.height.mas_equalTo(lineWight);
       }];
    }else if (locat==DradwBottomLine) {
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
            make.left.equalTo(@0.5);
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(lineWight);
        }];
    }else if (locat==DradwLeftLine) {
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.width.mas_equalTo(lineWight);
            make.height.equalTo(self.mas_height);
        }];
    }else if (locat==DradwRightLine) {
        [vi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(self.mas_right).offset(-lineWight);
            make.width.mas_equalTo(lineWight);
            make.height.equalTo(self.mas_height);
        }];
    }
}

-(UIView *)CreateLineViewColor:(UIColor *)col {
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = col;
    return view;
}
@end
