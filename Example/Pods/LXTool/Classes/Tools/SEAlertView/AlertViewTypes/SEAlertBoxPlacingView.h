//
//  SEAlertBoxPlacingView.h
//  SEUDApp
//
//  Created by 自制力 on 17/5/17.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

/**
 ******配售提示弹框
 */

#import "SEBaseAlertView.h"

@interface SEAlertBoxPlacingView : SEBaseAlertView
/**创建配售提示弹框，placingArray：配售信息*/
- (instancetype)initWithPlacingArray:(NSArray *)placingArray;
@end
