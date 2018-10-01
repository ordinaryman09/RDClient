//
//  ListView.m
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "ListView.h"

@implementation ListView

- (void) setupViews {
    [self addSubview:self.tableView];
    [self addSubview:self.scrollTopButton];
    [self.tableView addSubview:self.refreshControl];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    spinner.frame = CGRectMake(0, 0, 100, 44);
    self.tableView.tableFooterView = spinner;

}

- (void) setupLayout {
    [self.tableView autoPinEdgesToSuperviewEdges];
    [self.scrollTopButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.scrollTopButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [self.scrollTopButton autoSetDimensionsToSize:CGSizeMake(150, 44)];
}

- (UITableView *) tableView {
    if(_tableView) return _tableView;
    _tableView = [[UITableView alloc] initForAutoLayout];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 150.f;
    _tableView.estimatedRowHeight = 150.0f;
    return _tableView;
}

- (UIRefreshControl *) refreshControl {
    if(_refreshControl) return _refreshControl;
    _refreshControl = [UIRefreshControl new];
    return _refreshControl;
}

- (UIButton *) scrollTopButton {
    if(_scrollTopButton) return _scrollTopButton;
    _scrollTopButton = [[UIButton alloc] initForAutoLayout];
    [_scrollTopButton setTitle:@"Scroll to top" forState:UIControlStateNormal];
    _scrollTopButton.layer.cornerRadius = 22.5f;
    _scrollTopButton.backgroundColor = [UIColor colorWithRed:250/255.0 green:63/255.0 blue:57/255.0 alpha:1.0];
    return _scrollTopButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
