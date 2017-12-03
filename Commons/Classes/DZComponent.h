//
//  DZComponent.h
//  SEUDApp
//
//  Created by Souyun on 16/11/4.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DZComponent : NSObject


-(BOOL)diff:(NSString*)key;
-(void)render;
-(NSDictionary*)schema;
-(NSDictionary*)readSchema:(NSString*)name;
-(void)clearDiff;
-(NSString*)checkSchema:(id)prototype data:(id)value;
-(id)randomState:(NSDictionary*)schema;

@property(nonatomic,strong)NSDictionary* state;
@property(nonatomic,strong)id wrapper;

@end
