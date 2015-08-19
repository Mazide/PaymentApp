//
//  RequestExecutor.h
//  HotelLook
//
//  Created by Nikita Demidov on 01.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestExecutor : NSObject

- (void)executeHttpRequest:(NSURLRequest*)request withCompletion:(void (^)(id responce, NSError* error))completion;

@end
