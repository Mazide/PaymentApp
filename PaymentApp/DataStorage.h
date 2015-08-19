//
//  DataStorage.h
//  PaymentApp
//
//  Created by Nikita Demidov on 19.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataStorage : NSObject

- (NSArray*)getItems;

- (NSManagedObject*)createItem;

- (void)saveContext;

@end
