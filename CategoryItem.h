//
//  CategoryItem.h
//  
//
//  Created by Nikita Demidov on 20.08.15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoryItem;

@interface CategoryItem : NSManagedObject

@property (nonatomic, retain) NSNumber * categoryID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface CategoryItem (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(CategoryItem *)value;
- (void)removeRelationshipObject:(CategoryItem *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
