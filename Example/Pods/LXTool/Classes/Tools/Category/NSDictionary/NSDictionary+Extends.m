//
//  NSDictionary.m
//  SEUDApp
//
//  Created by Chengkai on 16/7/11.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "NSDictionary+Extends.h"

@implementation NSDictionary (Extends)

-(NSString*) se_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)(prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
