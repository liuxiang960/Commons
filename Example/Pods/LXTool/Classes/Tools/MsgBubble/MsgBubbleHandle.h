//
//  MsgBubbleHandle.h
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgBubbleHandle : NSObject

+ (instancetype)sharedInstance;

/**
 *  @author 程凯, 16-06-22 14:06:58
 *
 *  发送一条气泡消息
 *
 *  @param msg 消息内容，支持Html格式
 *
 *  @since 1.0
 */
-(void)msgBroadcastSingleMsg:(NSString *)msg;

/**
 *  @author 程凯, 16-06-22 14:06:28
 *
 *  发送一组气泡消息
 *
 *  @param msgs 消息数组，支持Html格式
 *
 *  @since 1.0
 */
-(void)msgBroadcastMultiMsg:(NSArray *)msgs;

@end
