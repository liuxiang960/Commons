//
//  UIView.h
//  TestViewToImage
//
//  Created by Chengkai on 16/7/16.
//  Copyright © 2016年 com.zkingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author 程凯, 16-07-16 13:07:20
 *
 *  UIView截图
 *
 *  @since 1.0
 */
@interface UIView (GetContextImage)

/**
 *  @author 程凯, 16-07-16 13:07:52
 *
 *  获取当前UIView的截图
 *
 *  @return 图片
 *
 *  @since 1.0
 */
-(UIImage *)seGetContextImage;

/**
 *  @author 程凯, 16-07-16 13:07:52
 *
 *  获取当前UIView指定frame内的截图
 *
 *  @param frame 限定的Frame
 *
 *  @return 图片
 *
 *  @since 1.0
 */
-(UIImage *)seGetContextImage:(CGRect)frame;

@end
