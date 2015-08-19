//
//  TableViewHelper.h
//  HotelLook
//
//  Created by Nikita Demidov on 10.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>

typedef void (^CellConfigureBlock)(UITableViewCell* cell, id dataObject, NSIndexPath* indexPath);
typedef NSString* (^CellIdentifierForIndexPathBlock)(NSIndexPath* indexPath);

@interface TableViewProtocolsHandler : NSObject

@property (strong, nonatomic) NSArray* dataObjects;
@property (copy, nonatomic) CellConfigureBlock cellConfigureBlock;
@property (copy, nonatomic) CellIdentifierForIndexPathBlock cellIdentifierForIndexPathBlock;

- (instancetype)initWithDataObjects:(NSArray*)dataObjects
               cellConfigurateBlock:(CellConfigureBlock)cellConfigurateBlock
                cellIdentifierBlock:(CellIdentifierForIndexPathBlock)cellIdentifierBlock;

@end
