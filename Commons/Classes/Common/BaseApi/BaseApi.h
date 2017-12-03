//
//  BaseApi.h
//  BottomProject
//
//  Created by 刘湘 on 2017/11/30.
//  Copyright © 2017年 刘湘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
typedef void(^apiCallBack)(BOOL success,int code,NSString* desc,NSObject* data,BaseViewController* curerentVc);
@interface BaseApi : NSObject
@property (nonatomic,copy) NSObject *data;
@property (nonatomic,weak) BaseViewController *currentVc;
@property (copy)apiCallBack CallBack;
-(void)jumpToBussions:(BaseViewController *)currentVc Data:(NSObject*)data CallBack:(apiCallBack)call;
@end
