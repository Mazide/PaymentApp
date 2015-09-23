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

- (instancetype)initWithEntity:(NSString*)entityName
                SortDescriptor:(NSSortDescriptor*)sortDescriptor
                     predicate:(NSPredicate*)mainCategotyPredicate;

- (NSArray*)getMainCategories;

- (NSManagedObject*)createCategory;

- (void)saveChanges;

- (void)clean;

@end
