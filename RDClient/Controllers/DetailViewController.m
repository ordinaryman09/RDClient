//
//  DetailViewController.m
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewController+Networking.h"
#import "DetailView.h"
NSString * const detailCellId = @"cellId";

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString* listingId;
@property (nonatomic, strong) DetailView *detailView;
@property (nonatomic, assign) BOOL isFetching;
@property (nonatomic, strong) NSMutableArray *comments;
@end

@implementation DetailViewController

- (instancetype) initWithListingId:(NSString *) listingId {
    self = [super init];
    if(self) {
        self.listingId = listingId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.comments = [NSMutableArray new];
    [self.detailView.tableView registerClass:[CommentCell class] forCellReuseIdentifier:detailCellId];
    
    [self.detailView.scrollTopButton addTarget:self action:@selector(handleScrollToTop:) forControlEvents:UIControlEventTouchUpInside];
    [self.detailView.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    [self loadDataWithReset:NO];
}

- (void) refreshData:(id) sender {
    [self loadDataWithReset:YES];
}

- (void) loadDataWithReset:(BOOL) reset {
    
    if(self.isFetching) return;
    
    self.isFetching = YES;
    
    if(reset) {
        [self.comments removeAllObjects];
        [self.detailView.tableView reloadData];
    }
    
    [self getCommentsForListingId:self.listingId success:^(id listingResponse, id commentsResponse) {
        //something wrong
        if([listingResponse count] == 0) {
            self.isFetching = NO;
            if([self.detailView.refreshControl isRefreshing]) [self.detailView.refreshControl endRefreshing];
            return;
        }
        Listing *listing = [listingResponse objectAtIndex:0];
        [self refreshUIWithListing:listing comments:commentsResponse];
        self.isFetching = NO;
        if([self.detailView.refreshControl isRefreshing]) [self.detailView.refreshControl endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupViews {
    [self.view addSubview:self.detailView];
}

- (void) setupLayout {
    [self.detailView autoPinEdgesToSuperviewEdges];
}

- (void) refreshUIWithListing:(Listing *) listing comments:(NSArray *) comments {
    [self.detailView setViewWithListing:listing];
    
    [self.detailView.tableView beginUpdates];
    NSInteger startIndex = self.comments.count;
    [self.comments addObjectsFromArray:comments];
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    
    for(NSInteger i = startIndex; i < startIndex + [comments count]; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self.detailView.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.detailView.tableView endUpdates];
    
}

- (DetailView *) detailView {
    if(_detailView) return _detailView;
    _detailView = [[DetailView alloc] initForAutoLayout];
    _detailView.tableView.delegate = self;
    _detailView.tableView.dataSource = self;
    return _detailView;
}


- (void) handleScrollToTop:(id) sender {
    
    [self.detailView.tableView setContentOffset:CGPointZero animated:YES];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Comment *comment = [self.comments objectAtIndex:indexPath.row];
    [cell setCellWithComment:comment];
    
    return cell;
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
