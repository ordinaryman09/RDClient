//
//  Comment.m
//  RDClient
//
//  Created by Richard Lung on 9/30/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "Comment.h"

@implementation Comment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"body": @"data.body",
             @"name" : @"data.name",
             @"cid" : @"data.id",
             @"author" : @"data.author"
             };
}


@end
