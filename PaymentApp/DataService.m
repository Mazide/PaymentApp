//
//  DataService.m
//  PaymentApp
//
//  Created by Nikita Demidov on 18.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "DataService.h"
#import "RequestExecutor.h"
#import "RequestCreator.h"
#import "DataStorage.h"

#import "CategoryItem.h"
#import "CategoryItem+Configure.h"

@interface DataService()

@property (strong, nonatomic) RequestExecutor* requestExecutor;
@property (strong, nonatomic) RequestCreator* requestCreator;
@property (strong, nonatomic) DataStorage* dataStorage;

@end

@implementation DataService

+ (id)sharedService
{
    static dispatch_once_t p = 0;
    __strong static DataService* sharedService = nil;
    
    dispatch_once(&p, ^{
        sharedService = [[self alloc] init];
    });
    
    return sharedService;
}

-(instancetype)init{
   
    self = [super init];
    if (self) {

        _requestExecutor = [[RequestExecutor alloc] init];
        _requestCreator  = [[RequestCreator alloc] init];
        _dataStorage     = [[DataStorage alloc] init];
    }
    return self;
}

-(void)downloadAllItemsWithCompletion:(void (^)(NSArray *, NSError *))completion{
    NSArray*  items = [_dataStorage getItems];
    if (items.count == 0) {
        [self loadFromItemsServerWithConpletion:completion];
    } else {
        NSLog(@"Loaded from DataStorage");
        completion ? completion(items, nil) : nil;
    }
}

- (void)loadFromItemsServerWithConpletion:(void (^)(NSArray *, NSError *))completion{
    NSURLRequest* categoriesRequest = [_requestCreator categoriesListRequest];
    
    __weak typeof(self) weakSelf = self;
    [_requestExecutor executeHttpRequest:categoriesRequest withCompletion:^(NSArray* categoriesInfo, NSError* error){
        
        NSMutableArray* categories = [[NSMutableArray alloc] init];
        for (NSDictionary* info in categoriesInfo) {
            
            CategoryItem* category = (CategoryItem*)[weakSelf.dataStorage createItem];
            [category configureWithItemInfo:info dataStorage:weakSelf.dataStorage];
            [categories addObject:category];
        }
        [weakSelf.dataStorage saveContext];
        
        NSLog(@"Loaded from Web");
        completion ? completion(categories , nil) : nil;
    }];

}


@end
