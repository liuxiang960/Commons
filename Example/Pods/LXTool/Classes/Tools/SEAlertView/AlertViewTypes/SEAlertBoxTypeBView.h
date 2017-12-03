//
//  SEAlertBoxTypeBView.h
//  SEUDApp
//
//  Created by Chengkai on 16/7/27.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEBaseAlertView.h"

/**
 *  @author 程凯, 16-07-27 15:07:02
 *
 *  不知道怎么用，请参考readme.rtfd(就在同级目录下)
 *
 *  @since 1.0
 */
@interface SEAlertBoxTypeBView : SEBaseAlertView

@property (nonatomic, strong) UILabel *lblTitle;/**< 顶部标题 */
@property (nonatomic, strong) UILabel *lblContentTitle;/**< 内容标题 */
@property (nonatomic, strong) UILabel *lblContentSubTitle;/**< 内容副标题 */
@property (nonatomic, copy) NSString *titleForBtn;/**< 按钮标题 */

@end
