//
//  DZComponent.m
//  SEUDApp
//
//  Created by Souyun on 16/11/4.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "DZComponent.h"

static NSDictionary* schemas = nil;

@interface DZComponent ()

@property(nonatomic,strong)NSMutableDictionary* diffMap;

@end

@implementation DZComponent

-(void)render{
    [self clearDiff];
}

-(NSDictionary*)schema{
    return nil;
}

-(NSDictionary*)readSchema:(NSString *)name{
    if ( !schemas ){
        NSString* filename = [[NSBundle mainBundle] pathForResource:@"schema" ofType:@"json"];
        NSString* content = [NSString stringWithContentsOfFile:filename
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
        schemas = [self dictionaryToJson:schemas];
    }
    return schemas[name];
}

-(NSString*)dictionaryToJson:(id )dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

-(BOOL)diff:(NSString *)key{
    return self.diffMap[key] != nil;
}

-(void)clearDiff{
    [self.diffMap removeAllObjects];
}

-(NSString*)checkSchema:(id)prototype data:(id)value{
    if ( !prototype ){
        return nil;
    }
    
    if ( !value ){
        return nil;
    }
    
    NSString* error = nil;
    
    if ( [value isKindOfClass:[NSDictionary class]] ){
        if ( prototype[@"type"] && [prototype[@"type"] isEqualToString:@"map"] ){
            prototype = prototype[@"range"];
        }
        for( NSString* key in [value allKeys] ){
            error = [self checkSchema:prototype[key] data:value[key]];
            if ( error ) break;
        }
    }
    else if ( [value isKindOfClass:[NSArray class]] ){
        if ( [prototype[@"type"]isEqualToString:@"array"] ){
        }
        else{
            for( NSDictionary* item in value ){
                error = [self checkSchema:prototype[@"range"] data:item];
                if ( error ) break;
            }
        }
    }
    else{
        BOOL pass = NO;
        NSString* range = prototype[@"range"];
        if ( [prototype[@"type"]isEqualToString:@"string"] ){
            if ( [value isKindOfClass:[NSString class]] ){
                if ( [range isKindOfClass:[NSArray class]] ){
                    NSArray* list = (NSArray*)range;
                    if ( [list indexOfObject:value] != NSNotFound ){
                        pass = YES;
                    }
                }
                else{
                    if ( range.length > 0 ){
                        if ( [range isEqualToString:@">0"] && [(NSString*)value length] > 0 ){
                            pass = YES;
                        }
                        else if ( [range isEqualToString:@">=0"] ){
                            pass = YES;
                        }
                        else if ( [range intValue] == [(NSString*)value length] ){
                            pass = YES;
                        }
                    }
                    else{
                        pass = YES;
                    }
                }
            }
        }
        else if ( [prototype[@"type"]isEqualToString:@"float"] ){
            if ( [value isKindOfClass:[NSNumber class]] ){
                if ( range.length > 0 ){
                    if ( [range isEqualToString:@">0"] && [(NSNumber*)value doubleValue] > 0 ){
                        pass = YES;
                    }
                    else if ( [range isEqualToString:@">=0"] && [(NSNumber*)value doubleValue] >= 0 ){
                        pass = YES;
                    }
                }
                else{
                    pass = YES;
                }
            }
        }
        else if ( [prototype[@"type"]isEqualToString:@"int"] ){
            if ( [value isKindOfClass:[NSNumber class]] ){
                if ( range.length > 0 ){
                    if ( [range isEqualToString:@">0"] && [(NSNumber*)value intValue] > 0 ){
                        pass = YES;
                    }
                    else if ( [range isEqualToString:@">=0"] && [(NSNumber*)value intValue] >= 0 ){
                        pass = YES;
                    }
                }
                else{
                    pass = YES;
                }
            }
        }
        else if ( [prototype[@"type"]isEqualToString:@"boolean"] ){
            if ( [value isKindOfClass:[NSNumber class]] ){
                pass = YES;
            }
        }
        else if ( [prototype[@"type"]isEqualToString:@"function"] ){
            if ( value ){
                pass = YES;
            }
        }
        else{
            error = @"type not found";
        }
        if ( !error && !pass ){
            error = @"type check not passed";
        }
    }
    
    if ( error ){
        NSLog(@"schema error %@ : %@",error,[value stringValue]);
    }
    
    return error;
}

#pragma mark - random state


-(int)randomInt{
    return arc4random()%100;
}

-(float)randomFloat{
    return (((double)arc4random() / 0x100000000))*100;
}

-(BOOL)randomBool{
    return arc4random()%2;
}

-(NSString*)randomString{
    NSMutableString* result = [[NSMutableString alloc]init];
    int length = arc4random()%10;
    int range = 'z' - 'a';
    for( int i = 0; i < 5+length; i++ ){
        char c = 'a'+(arc4random()*1000)%range;
        [result appendFormat:@"%c",c];
    }
    return result;
}

-(id)randomState:(NSDictionary*)schema{
    id state = nil;
    
    NSString* type = schema[@"type"];
    if ( !type ){
        state = [[NSMutableDictionary alloc]init];
        for( NSString* key in [schema allKeys] ){
            [state setObject:[self randomState:schema[key]] forKey:key];
        }
    }
    else{
        if ( [type isEqualToString:@"map"] ){
            state = [[NSMutableDictionary alloc]init];
            for( NSString* key in [schema[@"range"] allKeys] ){
                [state setObject:[self randomState:schema[@"range"][key]] forKey:key];
            }
        }
        else if ( [type isEqualToString:@"list"] ){
            state = [[NSMutableArray alloc]init];
            int length = [self randomInt];
            for( int i = 0; i < length; i++ ){
                [state addObject:[self randomState:schema[@"range"]]];
            }
        }
        else if ( [type isEqualToString:@"array"] ){
            state = [[NSMutableArray alloc]init];
            int length = [self randomInt];
            for( int i = 0; i < length; i++ ){
                if ( [schema[@"range"] isKindOfClass:[NSArray class]] ){
                    NSArray* array = schema[@"range"];
                    [state addObject:[array objectAtIndex:[self randomInt]%array.count]];
                }
                else{
                    [state addObject:[self randomString]];
                }
            }
        }
        else if ( [type isEqualToString:@"string"] ){
            state = [self randomString];
            if ( [schema[@"range"] isKindOfClass:[NSArray class]] ){
                NSArray* array = schema[@"range"];
                state = [array objectAtIndex:[self randomInt]%array.count];
            }
        }
        else if ( [type isEqualToString:@"int"] ){
            state = [NSNumber numberWithInt:[self randomInt]];
        }
        else if ( [type isEqualToString:@"float"] ){
            state = [NSNumber numberWithFloat:[self randomFloat]];
        }
        else if ( [type isEqualToString:@"boolean"] ){
            state = [NSNumber numberWithBool:[self randomBool]];
        }
        else{
            state = [NSNull null];
        }
    }
    
    return state;
}

#pragma mark - propertys

-(void)setState:(NSDictionary *)state{
    if ( !_state ){
        _state = [[NSMutableDictionary alloc]init];
    }
    NSMutableDictionary* _s = (NSMutableDictionary*)_state;
    if ( ![self checkSchema:self.wrapper?[self.wrapper schema]:self.schema data:state] ){
        for( NSString* key in [state allKeys] ){
            _s[key] = state[key];
            self.diffMap[key] = @(YES);
        }
    }
    if ( self.wrapper ){
        [self.wrapper render];
    }
    else{
        [self render];
    }
}

-(NSMutableDictionary*)diffMap{
    if ( !_diffMap ){
        _diffMap = [[NSMutableDictionary alloc]init];
    }
    return _diffMap;
}

@end
