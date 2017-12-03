//
//  UIView+Line.h
//  SEUDApp
//
//  Created by 刘湘 on 17/4/19.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DrawLocate)
{
    DradwTopLine = 0,/**  上*/
    DradwBottomLine = 1,/**下*/
    DradwLeftLine = 2,/** 左*/
    DradwRightLine = 3/**右*/
};
@interface UIView (Line)
-(void)DrawLineLocate:(DrawLocate)locat Corlor:(UIColor*)colr LineWidth:(CGFloat)lineWight;
@end
