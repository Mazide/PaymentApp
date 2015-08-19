//
//  RequestCreator.m
//  PaymentApp
//
//  Created by Nikita Demidov on 18.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "RequestCreator.h"

NSString* baseUrl = @"https://money.yandex.ru/api/";
NSString* categoriesMethod = @"categories-list";

NSTimeInterval timeOutInterval = 30.f;

@implementation RequestCreator

- (NSURLRequest *)categoriesListRequest{
    NSURL* categoriesURL = [NSURL URLWithString:[self categoriesUrlString]];
    NSURLRequest* categoriesRequest = [NSURLRequest requestWithURL:categoriesURL];
    return categoriesRequest;
}

#pragma mark - Urls

- (NSString*)categoriesUrlString{
    return [NSString stringWithFormat:@"%@%@", baseUrl, categoriesMethod];
}

@end
