//
//  BaseView.h
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PureLayout/PureLayout.h>
#import "Listing.h"
#import "Comment.h"

@interface BaseView : UIView

- (void) setupViews;
- (void) setupLayout;

@end

@interface ListingCell : UITableViewCell

- (void) setCellWithListing:(Listing*) listing;

@end

@interface CommentCell : UITableViewCell

- (void) setCellWithComment:(Comment*) comment;

@end
