//
//  Listing.h
//  RDClient
//
//  Created by Richard Lung on 9/30/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface Listing : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lid;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *author;

- (BOOL) hasThumbnail;

@end
