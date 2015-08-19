//
//  DataStorage.h
//  PaymentApp
//
//  Created by Nikita Demidov on 19.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryItem.h"

@interface DataStorage : NSObject

- (void)saveItems:(NSArray*)items withCompletion:(void (^)(NSError* error))completion;

- (CategoryItem*)createItem;

@end
