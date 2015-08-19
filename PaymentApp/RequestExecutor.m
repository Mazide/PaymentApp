//
//  RequestExecutor.m
//  HotelLook
//
//  Created by Nikita Demidov on 01.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "RequestExecutor.h"
#import <AFNetworking/AFNetworking.h>

@implementation RequestExecutor

- (void)executeHttpRequest:(NSURLRequest *)request withCompletion:(void (^)(id responce, NSError* error))completion{
    
    AFHTTPResponseSerializer* jsonSerializer = [AFJSONResponseSerializer serializer];
    [self executeRequest:request serializer:jsonSerializer withCompletion:completion];
}

- (void)executeRequest:(NSURLRequest*)request  serializer:(AFHTTPResponseSerializer*)serializer withCompletion:(void (^)(id responce, NSError* error))completion{
    
    AFHTTPRequestOperationManager *manager   = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = serializer;
    AFHTTPRequestOperation* requestOperation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation* requestOperation, id responce){
        completion ? completion(responce, nil) : nil;
    } failure:^(AFHTTPRequestOperation* requestOperation, NSError* error){
        completion ? completion(nil, error) : nil;
    }];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue addOperation:requestOperation];
}
@end
