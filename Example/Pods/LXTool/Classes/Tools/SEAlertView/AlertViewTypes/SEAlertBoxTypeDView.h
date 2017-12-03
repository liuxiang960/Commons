//
//  SEAlertBoxTypeDView.h
//  SEUDApp
//
//  Created by Chengkai on 16/8/19.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEBaseAlertView.h"

@interface SEAlertBoxTypeDView : SEBaseAlertView

@property (nonatomic, strong) UILabel *lblTitle;/**< 顶部标题 */
@property (nonatomic, strong) UILabel *lblContentTitle;/**< 内容标题 */
@property (nonatomic, strong) UILabel *lblContentTitle2;/**< 内容标题2，位置在lblContentTitle的下面 */
@property (nonatomic, strong) UILabel *lblContentSubTitle;/**< 内容副标题 */
@property (nonatomic, copy) NSString *titleForBtnCancel;/**< 『取消』按钮标题 */
@property (nonatomic, copy) NSString *titleForBtnSure;/**< 『确认』按钮标题 */
@property (nonatomic, assign) BOOL isHiddenCancelBtn;/**< 是否显示『取消』按钮. YES:隐藏  NO:显示 */

@end
