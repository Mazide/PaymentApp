//
//  Category.h
//  PaymentApp
//
//  Created by Nikita Demidov on 18.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject

@property (nonatomic) NSInteger categoryID;
@property (copy, nonatomic) NSString* title;
@property (strong, nonatomic) NSArray* subs;

- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end
