//
//  CategoryItem+Configure.m
//  PaymentApp
//
//  Created by Nikita Demidov on 19.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "CategoryItem+Configure.h"
#import "NSDictionary+SafeAccess.h"

NSString * const idKey    = @"id";
NSString * const titleKey = @"title";
NSString * const subsKey  = @"subs";

@implementation CategoryItem (Configure)


- (void)configureWithItemInfo:(NSDictionary*)itemInfo dataStorage:(DataStorage *)dataStorage{

    self.categoryID = [itemInfo valueForKey:idKey ifKindOf:[NSNumber class] defaultValue:@(0)];
    self.title      = [itemInfo valueForKey:titleKey ifKindOf:[NSString class] defaultValue:nil];
    self.timeStamp  = [NSDate date];
    
    NSArray* subsInfoArray = [itemInfo valueForKey:subsKey ifKindOf:[NSArray class] defaultValue:nil];

    for (NSDictionary* subinfo in subsInfoArray) {
        CategoryItem* subItem = (CategoryItem*)[dataStorage createCategory];
        [subItem configureWithItemInfo:subinfo dataStorage:dataStorage];
        [self addRelationshipObject:subItem];
    }
}

@end
