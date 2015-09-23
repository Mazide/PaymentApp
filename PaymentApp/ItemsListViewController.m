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
#import "TableViewProtocolsHandler.h"

#import "DataService.h"

#import "CategoryCell.h"
#import "CategoryCell+Configure.h"
#import "UITableViewCell+CellIndifier.h"
#import "CategoryItem.h"

@interface ItemsListViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoriesTableView;

@property (strong, nonatomic) TableViewDataSource* categoriesTableViewDataSource;

@property (strong, nonatomic) NSArray* categories;

@property (strong, nonatomic) DataService* dataService;

@property (weak, nonatomic) UIRefreshControl* refreshControl;

@end

@implementation ItemsListViewController{
    CellConfigureBlock configureBlock;
    NSString* cellIdentifier;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initRefreshControll];
    self.categoriesTableView.delegate = self;
    
    _dataService = [DataService sharedService];
    
    configureBlock = ^(UITableViewCell* cell, id infoObject, NSIndexPath* indexPath){
        [(CategoryCell*)cell configureWithCategory:infoObject];
    };
    
    cellIdentifier = [CategoryCell cellIdentifier];
    
    [self loadCategoriesFromDataStorage:NO];
}

- (void)initRefreshControll{
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [_categoriesTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(updateTableView) forControlEvents:UIControlEventValueChanged];
    
    _refreshControl = refreshControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - info loading

- (void)loadCategoriesFromDataStorage:(BOOL)loadFromLocalDataStorage{
    if (_selectedCategory) {
        _categories = _selectedCategory.relationship.allObjects;
        [self configureTableViewWithCategoryItem:_selectedCategory];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [_dataService downloadAllItems:loadFromLocalDataStorage completion:^(NSArray *items, NSError *error) {
        typeof(weakSelf) strongSelf = weakSelf;

        strongSelf.categories = items;

        [strongSelf configureTableViewWithItems:items];
    }];
}

#pragma mark - UITableView Manage

- (void)configureTableViewWithItems:(NSArray*)items{
    self.categoriesTableViewDataSource = [[TableViewDataSource alloc] initWithDataObjects:items
                                                                     cellConfigurateBlock:configureBlock
                                                                           cellIdentifier:cellIdentifier];
    
    self.categoriesTableView.dataSource = self.categoriesTableViewDataSource;
    [self.categoriesTableView reloadData];
}

- (void)configureTableViewWithCategoryItem:(CategoryItem*)categoryItem{
    self.title = categoryItem.title;
    _categoriesTableViewDataSource = [[TableViewDataSource alloc] initWithDataObjects:categoryItem.relationship.allObjects
                                                                 cellConfigurateBlock:configureBlock
                                                                       cellIdentifier:cellIdentifier];
    
    _categoriesTableView.dataSource = _categoriesTableViewDataSource;
    [_categoriesTableView reloadData];
}

#pragma mark - UI actions

- (void)updateTableView{
    [self loadCategoriesFromDataStorage:YES];
    [_refreshControl endRefreshing];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryItem* selectedCategory = (CategoryItem*)_categories[indexPath.row];
    
    if (selectedCategory.relationship.count == 0)
        return;
    
    ItemsListViewController *itemsListViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ItemsListViewController"];
    
    itemsListViewController.selectedCategory = selectedCategory;
    [self.navigationController pushViewController:itemsListViewController animated:YES];
}


@end
