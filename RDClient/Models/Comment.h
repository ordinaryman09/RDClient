//
//  Comment.h
//  RDClient
//
//  Created by Richard Lung on 9/30/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface Comment : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, copy) NSString *author;
@end
