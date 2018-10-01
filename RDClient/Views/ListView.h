//
//  ListView.h
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface ListView : BaseView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIButton *scrollTopButton;

@end
