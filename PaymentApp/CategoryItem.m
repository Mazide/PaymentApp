//
//  Category.m
//  PaymentApp
//
//  Created by Nikita Demidov on 18.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "CategoryItem.h"
#import "NSDictionary+SafeAccess.h"

NSString * const idKey    = @"id";
NSString * const titleKey = @"title";
NSString * const subsKey  = @"subs";

@implementation CategoryItem

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _categoryID = [[dict valueForKey:idKey ifKindOf:[NSNumber class] defaultValue:@(0)] integerValue];
        _title      = [dict valueForKey:titleKey ifKindOf:[NSString class] defaultValue:nil];
      
        NSArray* subsInfoArray = [dict valueForKey:subsKey ifKindOf:[NSArray class] defaultValue:nil];
        NSMutableArray* subs   = [[NSMutableArray alloc] init];
        for (NSDictionary* subinfo in subsInfoArray) {
            CategoryItem* subItem = [[CategoryItem alloc] initWithDictionary:subinfo];
            [subs addObject:subItem];
        }
        _subs = (NSArray*)subs;
        
    }
    return self;
}

@end
