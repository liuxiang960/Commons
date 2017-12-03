//
//  UILabel.h
//  SEUDApp
//
//  Created by 刘湘 on 16/12/8.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extends)

/**
 *  @author 刘湘, 16-08-19 15:08:59
 *
 *  设置文本，并设置行间距
 *
 *  @param text        lable上需要显示的文本
 *  @param lineSpacing 行间距
 *
 *  @since 1.0
 */
-(void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;

@end
