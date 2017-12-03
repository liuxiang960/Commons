//
//  NSString+Extend.h
//  CSDirectBank
//
//  Created by 程凯 on 15/8/16.
//  Copyright (c) 2015年 程凯. All rights reserved.
//

#import <CoreText/CoreText.h>
 
@interface NSAttributedString (Height)
-(CGFloat)boundingHeightForWidth:(CGFloat)inWidth;
@end