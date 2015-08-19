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
#import "CategoryItem.h"

@interface DataService()

@property (strong, nonatomic) RequestExecutor* requestExecutor;
@property (strong, nonatomic) RequestCreator* requestCreator;

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
    }
    return self;
}

-(void)downloadAllItemsWithCompletion:(void (^)(NSArray *, NSError *))completion{

    NSURLRequest* categoriesRequest = [_requestCreator categoriesListRequest];
    [_requestExecutor executeHttpRequest:categoriesRequest withCompletion:^(NSArray* categoriesInfo, NSError* error){
       
        NSMutableArray* categories = [[NSMutableArray alloc] init];
        for (NSDictionary* info in categoriesInfo) {
          
            CategoryItem* category = [[CategoryItem alloc] initWithDictionary:info];
            [categories addObject:category];
        }
        
        completion ? completion(categories , nil) : nil;
    }];
}

@end
