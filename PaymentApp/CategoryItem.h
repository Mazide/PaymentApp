//
//  CategoryItem.h
//  PaymentApp
//
//  Created by Nikita Demidov on 21.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoryItem;

@interface CategoryItem : NSManagedObject

@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface CategoryItem (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(CategoryItem *)value;
- (void)removeRelationshipObject:(CategoryItem *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
