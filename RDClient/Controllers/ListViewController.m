//
//  ListViewController.m
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "ListViewController.h"
#import "ListView.h"
#import "DetailViewController.h"

NSString * const cellId = @"cellId";

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) ListView *listView;
@property (nonatomic, strong) NSMutableArray *listings;
@property (nonatomic, assign) BOOL isFetching;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Bitcoin";
    self.listings = [NSMutableArray new];
    [self.listView.tableView registerClass:[ListingCell class] forCellReuseIdentifier:cellId];
    [self.listView.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
        
    [self.listView.scrollTopButton addTarget:self action:@selector(handleScrollToTop:) forControlEvents:UIControlEventTouchUpInside];
    [self loadDataWithReset:NO];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void) handleScrollToTop:(id) sender {
    
    [self.listView.tableView setContentOffset:CGPointZero animated:YES];
    
}

- (void) refreshData:(id) sender {
    [self loadDataWithReset:YES];
}

- (void) loadDataWithReset:(BOOL) reset {
    
    if(self.isFetching) return;
    
    self.isFetching = YES;
    
    if(reset) {
        [self.listings removeAllObjects];
        [self.listView.tableView reloadData];
    }
    
    Listing *listing = [self.listings lastObject];
    NSString *paginationAfterId;
    if(listing) {
        paginationAfterId = listing.name;
    }
    
    [self getListingsForType:@"hot" afterId:paginationAfterId success:^(id results) {
        
        [self.listView.tableView beginUpdates];
        NSInteger startIndex = self.listings.count;
        [self.listings addObjectsFromArray:results];
        
        NSMutableArray *indexPaths = [NSMutableArray new];
        
        for(NSInteger i = startIndex; i < startIndex + [results count]; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [self.listView.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.listView.tableView endUpdates];
       
        self.isFetching = NO;
        if([self.listView.refreshControl isRefreshing]) [self.listView.refreshControl endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupViews {
    [self.view addSubview:self.listView];
    
}

- (void) setupLayout {
    
    [self.listView autoPinEdgesToSuperviewEdges];
}

- (ListView *) listView {
    if(_listView) return _listView;
    _listView = [[ListView alloc] initForAutoLayout];
    _listView.tableView.delegate = self;
    _listView.tableView.dataSource = self;
    return _listView;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Listing *listing = [self.listings objectAtIndex:indexPath.row];
    [cell setCellWithListing:listing];
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Listing *listing = [self.listings objectAtIndex:indexPath.row];
    DetailViewController *dvc = [[DetailViewController alloc] initWithListingId:listing.lid];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listings.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //fetch more data if reach bottom
    if(indexPath.row == self.listings.count - 1) {
        [self loadDataWithReset:NO];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
