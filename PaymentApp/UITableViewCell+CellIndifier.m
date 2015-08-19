//
//  UITableViewCell+CellIndifier.m
//  HotelLook
//
//  Created by Nikita Demidov on 10.08.15.
//  Copyright (c) 2015 Nikita Demidov. All rights reserved.
//

#import "UITableViewCell+CellIndifier.h"

@implementation UITableViewCell (CellIndifier)

+ (NSString*)cellIdentifier{
    NSString* identifier = NSStringFromClass([self class]);
    return identifier;
}

@end
