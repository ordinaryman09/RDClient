//
//  Listing.m
//  RDClient
//
//  Created by Richard Lung on 9/30/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "Listing.h"

@implementation Listing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"data.title",
             @"name" : @"data.name",
             @"lid" : @"data.id",
             @"thumbnail" : @"data.thumbnail",
             @"author" : @"data.author"
             };
}

- (BOOL) hasThumbnail {
    return self.thumbnail && ![self.thumbnail isEqualToString:@"self"];
}

@end
