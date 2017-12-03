//
//  BaseView.h
//  SEUDApp
//
//  Created by Souyun on 16/6/1.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

-(void)addSubView:(UIView*)view;
-(void)removeFromSuperview;

-(void)postEvent:(NSString*)name;
-(void)postEvent:(NSString*)name data:(id)data;
@property(nonatomic,weak)id parent;
@property(nonatomic,readonly)id model;


///////////////////////////////// DZComponent /////////////////////////////////

-(BOOL)diff:(NSString*)key;
-(void)render;
-(NSDictionary*)schema;
-(NSDictionary*)readSchema:(NSString*)name;
-(void)clearDiff;
-(void)startRandomState;
-(void)stopRandomState;

@property(nonatomic,strong)NSDictionary* state;


@end
