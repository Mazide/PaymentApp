//
//  TableViewHelper.m
//  HotelLook
//
//  Created by Nikita Demidov on 10.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "TableViewProtocolsHandler.h"

@implementation TableViewProtocolsHandler

- (instancetype)initWithDataObjects:(NSArray *)dataObjects cellConfigurateBlock:(CellConfigureBlock)cellConfigurateBlock cellIdentifierBlock:(CellIdentifierForIndexPathBlock)cellIdentifierBlock{
    
    self = [super init];
    if (self) {
        _dataObjects        = dataObjects;
        _cellConfigureBlock = [cellConfigurateBlock copy];
        _cellIdentifierForIndexPathBlock = [cellIdentifierBlock copy];
    }
    return self;
}

@end
