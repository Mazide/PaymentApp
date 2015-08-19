//
//  CategoryItem+Configure.h
//  PaymentApp
//
//  Created by Nikita Demidov on 19.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "CategoryItem.h"
#import "DataStorage.h"

@interface CategoryItem (Configure)

- (void)configureWithItemInfo:(NSDictionary*)itemInfo dataStorage:(DataStorage*)dataStorage;

@end
