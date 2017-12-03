//
//  SEAlertView.h
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SEAlertViewBlock)();

/**
 *  @author 程凯, 16-06-22 22:06:01
 *
 *  App更新提示时，消息提示框
 *
 *  @since 1.0
 */
@interface SEAlertView : UIView

@property (nonatomic, copy) NSString *title;/**< 弹出框的标题 */
@property (nonatomic, copy) NSString *message;/**< 弹出框的内容 */
@property (nonatomic, copy) NSString *htmlMessage;/**< html内容 */
@property (nonatomic, copy) NSString *leftButtonTitle;/**< 弹出框底部左边按钮上的文字 */
@property (nonatomic, copy) NSString *rightButtonTitle;/**< 弹出框底部右边按钮上的文字 */
@property (nonatomic, strong) UIFont *titleFont;/**< 弹出框标题的字体 */
@property (nonatomic, strong) UIFont *messageFont;/**< 弹出框内容的字体 */
@property (nonatomic, assign) BOOL isLeftBtnHidden;/**< 是否隐藏弹出框底部左边的按钮 */
@property (nonatomic, strong)NSMutableArray* textList;

/**
 *  @author 程凯, 16-06-22 22:06:52
 *
 *  显示弹框, 如需隐藏弹出框需调用dismissAlertView
 *
 *  @param cancleAction 取消按钮(弹出框左边按钮)点击事件回调
 *  @param sureAction   确定按钮(弹出框右边按钮)点击事件回调
 *
 *  @since 1.0
 */
-(void)showAlertView:(SEAlertViewBlock)cancleAction sureAction:(SEAlertViewBlock)sureAction;

/**
 *  @author 程凯, 16-06-22 22:06:30
 *
 *  显示弹框，调用该方法时：取消按钮(弹出框左边按钮)的事件默认为隐藏当前弹出框
 *
 *  @param sureAction 确定按钮(弹出框右边按钮)点击事件回调
 *
 *  @since 1.0
 */
-(void)showAlertView:(SEAlertViewBlock)sureAction;

/**
 *  @author 程凯, 16-06-22 23:06:58
 *
 *  隐藏弹出框。
 *
 *  @since 1.0
 */
-(void)dismissAlertView;

@end
