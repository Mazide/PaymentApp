//
//  DataService.h
//  PaymentApp
//
//  Created by Nikita Demidov on 18.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject

+ (instancetype)sharedService;

- (void)downloadAllItemsWithCompletion:(void (^)(NSArray* items, NSError* error))completion;

@end
