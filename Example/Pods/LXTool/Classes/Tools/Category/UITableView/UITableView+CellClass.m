//
//  UITableView+CellClass.m
//  Animations
//
//  Created by Chengkai on 16/6/12.
//  Copyright © 2016年 Chengkai. All rights reserved.
//

#import "UITableView+CellClass.h"

@implementation UITableView (CellClass)

- (void)registerCellsClass:(NSArray <CellClassType *> *)cellClasses {

    for (int i = 0; i < cellClasses.count; i++) {
        
        CellClassType *cellClass = cellClasses[i];
        [self registerClass:NSClassFromString(cellClass.classString) forCellReuseIdentifier:cellClass.reuseIdentifier];
    }
}

@end

@implementation CellClassType

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString
                             reuseIdentifier:(NSString *)reuseIdentifier {
    
    NSParameterAssert(NSClassFromString(classString));
    
    CellClassType *type  = [[[self class] alloc] init];
    type.classString     = classString;
    type.reuseIdentifier = reuseIdentifier;
    
    return type;
}

+ (instancetype)cellClassTypeWithClassString:(NSString *)classString {

    NSParameterAssert(NSClassFromString(classString));
    
    CellClassType *type  = [[[self class] alloc] init];
    type.classString     = classString;
    type.reuseIdentifier = classString;
    
    return type;
}

@end