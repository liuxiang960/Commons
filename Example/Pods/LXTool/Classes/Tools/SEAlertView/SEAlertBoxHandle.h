//
//  SEAlertBoxHandle.h
//  SEUDApp
//
//  Created by Chengkai on 16/7/27.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SEBaseAlertView.h"
#import "SEAlertBoxTypeAView.h"
#import "SEAlertBoxTypeBView.h"
#import "SEAlertBoxTypeCView.h"
#import "SEAlertBoxTypeDView.h"
#import "SEAlertBoxPlacingView.h"

typedef NS_ENUM(NSInteger, SEAlertBoxType)
{
    SEAlertBoxTypeA = 0,/**< 类型A: 标题、内容标题、内容副标题、两个按钮, 效果图请参考当前分组下: readme.rtfd */
    SEAlertBoxTypeB = 1,/**< 类型B: 标题、内容标题、内容副标题、单个按钮，效果图参考: readme.rtfd */
    SEAlertBoxTypeC = 2,/**< 类型C: app更新时的弹框 */
    SEAlertBoxTypeD = 3,/**< 类型D: 标题、内容标题、内容标题2、内容副标题、两个按钮 */
};

@interface SEAlertBoxHandle : NSObject

/**
 *  @author 程凯, 16-07-27 17:07:17
 *
 *  创建一个弹框
 *
 *  @param boxType 弹框类型
 *
 *  @return 弹框实例
 *
 *  @since 1.0
 */
+(SEBaseAlertView *)createAlertBoxView:(SEAlertBoxType)boxType;

/**
 *  @author 颜双辉, 17-05-18 10:58:01
 *
 *  创建一个配售提示弹框
 *
 *  @param placingArray 配售信息
 *
 *  @return 弹框实例
 *
 *  @since 1.0
 */
+(SEBaseAlertView *)createAlertPlacingViewWithPlacingArray:(NSArray *)placingArray;

/**
 *  @author 程凯, 16-07-30 08:07:09
 *
 *  移除所有弹框
 *
 *  @since 1.0
 */
+(void)dismissAllAlertView;

@end
