//
//  TableViewDelegate.h
//  HotelLook
//
//  Created by Nikita Demidov on 10.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewProtocolsHandler.h"

@class TableViewDelegate;

@protocol TableViewDelegateDelegate <NSObject>

@optional
- (void)tableViewDelegate:(TableViewDelegate*)tableViewDelegate didSelectObject:(id)selectedObject;

@end

@interface TableViewDelegate : TableViewProtocolsHandler <UITableViewDelegate>

@property (weak, nonatomic) id<TableViewDelegateDelegate> delegate;

@end
