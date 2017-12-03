//
//  SEAlertBoxHandle.m
//  SEUDApp
//
//  Created by Chengkai on 16/7/27.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEAlertBoxHandle.h"

@implementation SEAlertBoxHandle

+(SEBaseAlertView *)createAlertBoxView:(SEAlertBoxType)boxType{
    
    SEBaseAlertView *result;
    switch (boxType) {
        case SEAlertBoxTypeA:
        {
            result = [[SEAlertBoxTypeAView alloc] init];
        }
            break;
        case SEAlertBoxTypeB:
        {
            result = [[SEAlertBoxTypeBView alloc] init];
        }
            break;
        case SEAlertBoxTypeC:
        {
            result = [[SEAlertBoxTypeCView alloc] init];
        }
            break;
        case SEAlertBoxTypeD:
        {
            result = [[SEAlertBoxTypeDView alloc] init];
        }
            break;
        default:
            break;
    }
    return result;
}

/**配售提示弹框*/
+(SEBaseAlertView *)createAlertPlacingViewWithPlacingArray:(NSArray *)placingArray{
    SEBaseAlertView *result = [[SEAlertBoxPlacingView alloc] initWithPlacingArray:placingArray];
    return result;
}

+(void)dismissAllAlertView{
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSArray *tmpSubViews = keyWindow.subviews;
    UIView *tmpView;
    for (int i = 0; i < tmpSubViews.count; i++) {
        tmpView = tmpSubViews[i];
        if (tmpView.tag == 9134) {
            [tmpView removeFromSuperview];
            tmpView = nil;
        }
    }
}

@end
