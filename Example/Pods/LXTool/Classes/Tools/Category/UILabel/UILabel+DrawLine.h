//
//  UILabel+DrawLine.h
//  SEUDApp
//
//  Created by 刘湘 on 17/3/9.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DrawLine)
/*!
 *  @author 刘湘, 17-03-09 20:03:08
 *
 *  @brief 进行画线
 *
 *  @param content  文字内容
 *  @param location 0是下划线 1是顶部画线 2是中间画线
 *
 *  @since <#1.0.4#>
 */
-(void)setContent:(NSString *)content DrawlineLoction:(NSInteger)location;
@end
