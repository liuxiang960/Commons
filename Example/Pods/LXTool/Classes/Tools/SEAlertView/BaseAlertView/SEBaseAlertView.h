//
//  SEAlertBox.h
//  SEUDApp
//
//  Created by Chengkai on 16/7/27.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author 程凯, 16-07-27 18:07:54
 *
 *  弹框类型, 取值范围参考枚举，效果图参考SEAlertView分组下的readme.rtfd
 *
 *  @since 1.0
 */
typedef NS_ENUM(NSInteger, SEAlertBoxButtonFlag) {
    AlertBoxButtonDefault = 0,/**< 默认值，如果弹框只有一个按钮，则该按钮对应该值 */
    AlertBoxButtonClose = 1,/**< 关闭按钮（右上角） */
    AlertBoxButtonCancel = 2,/**< 『取消』按钮 */
    AlertBoxButtonSure = AlertBoxButtonDefault /**< 『确认』按钮 */
};
typedef void(^SEAlertBoxBlock)(SEAlertBoxButtonFlag flag);


@interface SEBaseAlertView : UIView

@property (nonatomic, strong) UIView *bgView;/**< 蒙层背景 */
@property (nonatomic, assign) BOOL isBgViewTapEnable;/**< 弹框背景是否可以点击(点击退出) */
@property (nonatomic, assign) BOOL isAnimation;/**< 是否开启动画，弹出和隐藏的动画 */

-(void)show:(SEAlertBoxBlock)callback;/**< 显示弹框 */
-(void)dismiss;/**< 隐藏弹框 */

@end
