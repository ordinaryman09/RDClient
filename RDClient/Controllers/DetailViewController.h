//
//  DetailViewController.h
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface DetailViewController : BaseController

- (instancetype) initWithListingId:(NSString*) listingId;

@end
