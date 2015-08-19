//
//  HotelsListViewController.m
//  HotelLook
//
//  Created by Nikita Demidov on 01.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "ItemsListViewController.h"

#import "DataService.h"

#import "RequestExecutor.h"

#import "TableViewDataSource.h"
#import "TableViewDelegate.h"
#import "TableViewProtocolsHandler.h"

#import "DataService.h"

#import "CategoryCell.h"
#import "CategoryCell+Configure.h"
#import "UITableViewCell+CellIndifier.h"
#import "CategoryItem.h"

@interface ItemsListViewController () <TableViewDelegateDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;

@property (strong, nonatomic) TableViewDataSource* categoriesTableViewDataSource;
@property (strong, nonatomic) TableViewDelegate* categoriesTableViewDelegate;

@property (strong, nonatomic) NSArray* categories;

@property (strong, nonatomic) DataService* dataService;

@end

@implementation ItemsListViewController{
    CellConfigureBlock configureBlock;
    CellIdentifierForIndexPathBlock cellIdentifierBlock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataService = [DataService sharedService];
    
    configureBlock = ^(UITableViewCell* cell, id infoObject, NSIndexPath* indexPath){
        [(CategoryCell*)cell configureWithCategory:infoObject];
    };
    
    NSString* cellIdentifier = [CategoryCell cellIdentifier];
    cellIdentifierBlock = ^ NSString* (NSIndexPath* indexPath){
        return cellIdentifier;
    };
    
    if (_selectedCategory) {
        [self loadFromCategoryItem:_selectedCategory];
    } else {
        [self loadFromDataService];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFromCategoryItem:(CategoryItem*)categoryItem{
    self.title = categoryItem.title;
    _categoriesTableViewDataSource = [[TableViewDataSource alloc] initWithDataObjects:categoryItem.subs
                                                                 cellConfigurateBlock:configureBlock
                                                                  cellIdentifierBlock:cellIdentifierBlock];
    
    _categoriesTableViewDelegate = [[TableViewDelegate alloc] initWithDataObjects:categoryItem.subs
                                                             cellConfigurateBlock:configureBlock
                                                              cellIdentifierBlock:cellIdentifierBlock];
    
    _categoriesTableView.delegate   = _categoriesTableViewDelegate;
    _categoriesTableView.dataSource = _categoriesTableViewDataSource;
    [_categoriesTableView reloadData];
}

- (void)loadFromDataService{

    __weak typeof(self) weakSelf = self;
    [_dataService downloadAllItemsWithCompletion:^(NSArray *items, NSError *error) {
        typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.categoriesTableViewDataSource = [[TableViewDataSource alloc] initWithDataObjects:items
                                                                             cellConfigurateBlock:configureBlock
                                                                              cellIdentifierBlock:cellIdentifierBlock];
        
        strongSelf.categoriesTableViewDelegate = [[TableViewDelegate alloc] initWithDataObjects:items
                                                                         cellConfigurateBlock:configureBlock
                                                                          cellIdentifierBlock:cellIdentifierBlock];

        strongSelf.categoriesTableView.delegate   = strongSelf.categoriesTableViewDelegate;
        strongSelf.categoriesTableView.dataSource = strongSelf.categoriesTableViewDataSource;
        strongSelf.categoriesTableViewDelegate.delegate = strongSelf;
        [strongSelf.categoriesTableView reloadData];
    }];
}

#pragma mark - TableViewDelegate Delegate

-(void)tableViewDelegate:(TableViewDelegate *)tableViewDelegate didSelectObject:(id)selectedObject{
    
    CategoryItem* selectedCategory = (CategoryItem*)selectedObject;

    if (selectedCategory.subs.count == 0)
        return;

    
    ItemsListViewController *itemsListViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ItemsListViewController"];
    
    itemsListViewController.selectedCategory = selectedCategory;
    [self.navigationController pushViewController:itemsListViewController animated:YES];
}

@end
