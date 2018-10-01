//
//  DetailView.m
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "DetailView.h"

@interface DetailView()
@property (nonatomic, strong) UILabel *textLabel, *authorLabel;

@end

@implementation DetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setupViews {
    [self addSubview:self.textLabel];
    [self addSubview:self.authorLabel];
    [self addSubview:self.tableView];
    [self addSubview:self.scrollTopButton];
    [self.tableView addSubview:self.refreshControl];

}

- (void) setupLayout {
    [self.textLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(15, 15, 15, 15) excludingEdge:ALEdgeBottom];
    [self.authorLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.textLabel];
    [self.authorLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.textLabel withOffset:5];
    
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authorLabel withOffset:10];
    
    [self.scrollTopButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.scrollTopButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [self.scrollTopButton autoSetDimensionsToSize:CGSizeMake(150, 44)];
}

- (UILabel *) textLabel {
    if(_textLabel) return _textLabel;
    _textLabel = [[UILabel alloc] initForAutoLayout];
    _textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    _textLabel.numberOfLines = 0;
    _textLabel.clipsToBounds = YES;
    _textLabel.text = @"Loading...";
    return _textLabel;
}

- (UILabel *) authorLabel {
    if(_authorLabel) return _authorLabel;
    _authorLabel = [[UILabel alloc] initForAutoLayout];
    _authorLabel.font = [UIFont systemFontOfSize:13.0f];
    _authorLabel.textColor = [UIColor grayColor];
    return _authorLabel;
}

- (UIRefreshControl *) refreshControl {
    if(_refreshControl) return _refreshControl;
    _refreshControl = [UIRefreshControl new];
    return _refreshControl;
}

- (UITableView *) tableView {
    if(_tableView) return _tableView;
    _tableView = [[UITableView alloc] initForAutoLayout];
    _tableView.rowHeight = 85.0f;
    _tableView.estimatedRowHeight = 85.0f;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return _tableView;
}

- (void) setViewWithListing:(Listing *)listing {
    self.textLabel.text = listing.title;
    self.authorLabel.text = [NSString stringWithFormat:@"By: %@", listing.author];
}

- (UIButton *) scrollTopButton {
    if(_scrollTopButton) return _scrollTopButton;
    _scrollTopButton = [[UIButton alloc] initForAutoLayout];
    [_scrollTopButton setTitle:@"Scroll to top" forState:UIControlStateNormal];
    _scrollTopButton.layer.cornerRadius = 22.5f;
    _scrollTopButton.backgroundColor = [UIColor colorWithRed:250/255.0 green:63/255.0 blue:57/255.0 alpha:1.0];
    return _scrollTopButton;
}


@end
