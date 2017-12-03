//
//  SEAlertBoxTypeCView.h
//  SEUDApp
//
//  Created by Chengkai on 16/8/3.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEBaseAlertView.h"

@interface SEAlertBoxTypeCView : SEBaseAlertView

@property (nonatomic, strong) UILabel *lblTitle;/**< 顶部标题 */
@property (nonatomic, strong) UILabel *lblTitlePlus;/**< 顶部标题补充信息 */
@property (nonatomic, strong) UILabel *lblContentTitle;/**< 内容标题 */
@property (nonatomic, strong) UILabel *lblContentSubTitle;/**< 内容副标题 */
@property (nonatomic, copy) NSString *titleForBtnCancel;/**< 『取消』按钮标题 */
@property (nonatomic, copy) NSString *titleForBtnSure;/**< 『确认』按钮标题 */
@property (nonatomic, assign) BOOL isHiddenCancelBtn;/**< 是否隐藏"取消按钮" */
@property (nonatomic, assign) BOOL isHiddenCloseBtn;/**< 是否隐藏"关闭"按钮 */
@property (nonatomic, strong)NSMutableArray* textList;/** 显示多条文本 */
@property (nonatomic, strong)NSMutableArray* titleList;/** 西施多条标题 */

@end
