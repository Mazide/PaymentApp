//
//  HotelsListDataSourse.m
//  HotelLook
//
//  Created by Nikita Demidov on 01.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "TableViewDataSource.h"

@implementation TableViewDataSource

#pragma mark - UITableview DataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [self.dataObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id dataObject = self.dataObjects[indexPath.row];
    self.cellConfigureBlock(cell, dataObject, indexPath);
    return cell;
}

@end
