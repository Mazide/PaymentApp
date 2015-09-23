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
        _dataStorage     = [self getDataStorage];
    }
    return self;
}

- (DataStorage*)getDataStorage{
   
    NSString* entityName             = NSStringFromClass([CategoryItem class]);
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp.timeIntervalSinceReferenceDate" ascending:YES];
    NSPredicate* predicate           = [NSPredicate predicateWithFormat:@"ANY categoryID == 0"];
    
    DataStorage* dataStorage = [[DataStorage alloc] initWithEntity:entityName SortDescriptor:sortDescriptor predicate:predicate];
    return dataStorage;
}

- (void)downloadAllItems:(BOOL)flag completion:(void (^)(NSArray* items, NSError* error))completion{
    NSArray*  items = [_dataStorage getMainCategories];
    if (items.count == 0 || flag) {
        [self loadFromItemsServerWithCompletion:completion];
        NSLog(@"Loaded from Web");
    } else {
        NSLog(@"Loaded from DataStorage");
        completion ? completion(items, nil) : nil;
    }
}

- (void)loadFromItemsServerWithCompletion:(void (^)(NSArray *, NSError *))completion{
    NSURLRequest* categoriesRequest = [_requestCreator categoriesListRequest];
    
    __weak typeof(self) weakSelf = self;
    [_requestExecutor executeHttpRequest:categoriesRequest withCompletion:^(NSArray* categoriesInfo, NSError* error){
        
        [weakSelf.dataStorage clean];
        
        NSMutableArray* categories = [[NSMutableArray alloc] init];
        for (NSDictionary* info in categoriesInfo) {
            
            CategoryItem* category = (CategoryItem*)[weakSelf.dataStorage createCategory];
            [category configureWithItemInfo:info dataStorage:weakSelf.dataStorage];
            [categories addObject:category];
        }
        [weakSelf.dataStorage saveChanges];
        
        NSLog(@"Loaded from Web");
        completion ? completion(categories , nil) : nil;
    }];

}


@end
