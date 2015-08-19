//
//  CategoryCell+Configure.m
//  PaymentApp
//
//  Created by Nikita Demidov on 18.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "CategoryCell+Configure.h"

@implementation CategoryCell (Configure)

-(void)configureWithCategory:(CategoryItem *)categoryItem{
    self.title.text = categoryItem.title;
    [self.title sizeToFit];
}

@end
