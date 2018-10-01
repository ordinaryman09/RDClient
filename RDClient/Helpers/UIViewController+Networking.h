//
//  UIViewController+Networking.h
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Listing.h"
#import "Comment.h"

@interface UIViewController (Networking)

- (void) getListingsForType:(NSString *) type
                    afterId:(NSString *) afterId
                    success:(void (^)(id results))success;

- (void) getCommentsForListingId:(NSString *) listingId
                         success:(void (^)(id listing, id comments))success;


@end
