//
//  CategoryCell+Configure.h
//  PaymentApp
//
//  Created by Nikita Demidov on 18.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "CategoryCell.h"
#import "CategoryItem.h"

@interface CategoryCell (Configure)

- (void)configureWithCategory:(CategoryItem*)categoryItem;

@end
