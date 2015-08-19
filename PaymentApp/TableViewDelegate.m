//
//  TableViewDelegate.m
//  HotelLook
//
//  Created by Nikita Demidov on 10.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "TableViewDelegate.h"

@interface TableViewDelegate()


@end

@implementation TableViewDelegate

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewDelegate:didSelectObject:)]) {
        id selectedObject = self.dataObjects[indexPath.row];
        [self.delegate tableViewDelegate:self didSelectObject:selectedObject];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return [self heightForBasicCellAtIndexPath:indexPath tableView:tableView];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView*)tableView{
    
    NSString* cellIdentifier = self.cellIdentifierForIndexPathBlock ? self.cellIdentifierForIndexPathBlock(indexPath) : nil;
    
    UITableViewCell *sizingCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    id dataObject = self.dataObjects[indexPath.row];
    self.cellConfigureBlock ? self.cellConfigureBlock(sizingCell, dataObject, indexPath) : nil;
    return [self calculateHeightForConfiguredSizingCell:sizingCell tableView:tableView];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell tableView:(UITableView*)tableView{
   
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

@end
