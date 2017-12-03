//
//  UIView.m
//  TestViewToImage
//
//  Created by Chengkai on 16/7/16.
//  Copyright © 2016年 com.zkingsoft. All rights reserved.
//

#import "UIView+GetContextImage.h"

@implementation UIView (GetContextImage)

- (UIImage *)seGetContextImage
{
    return [self seGetContextImage:self.frame];
}

-(UIImage *)seGetContextImage:(CGRect)frame{
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(frame);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;
}

@end
