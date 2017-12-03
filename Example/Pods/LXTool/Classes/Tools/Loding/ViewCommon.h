//
//  ViewCommon.h
//  SEUDApp
//
//  Created by Souyun on 16/5/31.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewCommon : NSObject

+(void)toast:(NSString*)text;
+(void)openQQ:(NSString*)qq;
+(void)showSharePad:(NSString*)url;
+(void)showOperatorNotification:(NSString*)title content:(NSString*)content;
+(void)showUpgradeNotification:(NSString*)title content:(NSString*)content url:(NSString*)url must:(BOOL)must;
+(void)showExchangeBubble:(NSString*)text;


/**
 *  @author 程凯, 16-06-12 18:06:12
 *
 *  吐司弹框, 黑色透明背景，带红色的边框,文本过长会自动换行
 *
 *  @param message 提示的文本
 *
 *  @since 1.0
 */
+(void)toastWarning:(NSString *)message;

+(void)showLoadingView;
/*!
 *  @author 杜鹏, 17-5-15 15:11:11
 *
 *  @brief 自定义loding
 *
 *  @param mode YES:蒙版全覆盖;NO:蒙版不覆盖左上角
 *  @since 1.0.2
 */
+(void)showLoadingViewWithMode:(BOOL)mode;
+(void)dismissLoadingView;
+(void)dismissHiddenInterval:(NSTimeInterval)time;/**超时*/

@end
