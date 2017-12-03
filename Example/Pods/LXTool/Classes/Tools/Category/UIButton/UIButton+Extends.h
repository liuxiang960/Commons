//
//  UIButton.h
//  SEUDApp
//
//  Created by Chengkai on 16/8/19.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extends)

/**
 *  @author 程凯, 16-08-19 14:08:50
 *
 *  开始倒计时
 *
 *  @param secs 倒计时时间(秒)
 *
 *  @since 1.0
 */
-(void)startCountdown:(NSInteger)secs;
-(void)startCountdown:(NSInteger)secs backgroundImage:(UIImage*)image;
@property(nonatomic,assign)BOOL isCstomBol;//是否使用自定义
@end
