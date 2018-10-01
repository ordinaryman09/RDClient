//
//  BaseView.m
//  RDClient
//
//  Created by Richard Lung on 9/29/18.
//  Copyright © 2018 Richard Lung. All rights reserved.
//

#import "BaseView.h"
#import <UIImageView+AFNetworking.h>

@implementation BaseView

- (instancetype) init {
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
        [self setupLayout];
    }
    return self;
}

- (void) setupViews {}
- (void) setupLayout {}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@interface ListingCell()
@property (nonatomic, strong) UIImageView *thumbnailView;
@property (nonatomic, strong) UILabel *listingTitle, *listingAuthor;
@property (nonatomic, strong) UIView *cardView;
@end

@implementation ListingCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setupViews];
        [self setupLayout];
    }
    return self;
}

- (void) setupViews {
    [self.cardView addSubview:self.thumbnailView];
    [self.cardView addSubview:self.listingTitle];
    [self.cardView addSubview:self.listingAuthor];
    [self.contentView addSubview:self.cardView];
}

- (void) setupLayout {
    
    [self.cardView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    
    [self.listingAuthor autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.thumbnailView];
    [self.listingAuthor autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.thumbnailView withOffset:12.5];
    [self.listingAuthor autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12.5 relation:NSLayoutRelationGreaterThanOrEqual];
    
    [self.thumbnailView autoSetDimensionsToSize:CGSizeMake(50, 50)];
    [self.thumbnailView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12.5];
    [self.thumbnailView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12.5];
    
    [self.listingTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.thumbnailView];
    [self.listingTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.thumbnailView withOffset:15];
    [self.listingTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.listingTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12.5];
    
    
    
}

- (void) layoutSubviews {
    [self.contentView layoutSubviews];
    [self setupCard];
}

- (UIImageView *) thumbnailView {
    if(_thumbnailView) return _thumbnailView;
    _thumbnailView = [[UIImageView alloc] initForAutoLayout];
    _thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailView.backgroundColor = [UIColor redColor];
    _thumbnailView.clipsToBounds = YES;
    _thumbnailView.layer.cornerRadius = 25;
    _thumbnailView.backgroundColor = [UIColor whiteColor];
    return _thumbnailView;
}

- (UILabel *) listingTitle {
    if(_listingTitle) return _listingTitle;
    _listingTitle = [[UILabel alloc] initForAutoLayout];
    _listingTitle.numberOfLines = 0;
    return _listingTitle;
}

- (UILabel *) listingAuthor {
    if(_listingAuthor) return _listingAuthor;
    _listingAuthor = [[UILabel alloc] initForAutoLayout];
    _listingAuthor.numberOfLines = 1;
    return _listingAuthor;
}


- (UIView *) cardView {
    if(_cardView) return _cardView;
    _cardView = [[UIView alloc] initForAutoLayout];
    _cardView.backgroundColor = [UIColor whiteColor];
    return _cardView;
}

- (void) setupCard {
    [self.cardView setAlpha:1.0];
    self.cardView.layer.masksToBounds = NO;
    self.cardView.layer.shadowOffset = CGSizeMake(.2f, .2f);
    self.cardView.layer.shadowRadius = 3;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.cardView.bounds, UIEdgeInsetsMake(2, 0, 2, 0))];
    self.cardView.layer.shadowPath = path.CGPath;
    self.cardView.layer.shadowOpacity = 0.2;
}

- (void) setCellWithListing:(Listing*) listing {
    self.listingTitle.text = listing.title;
    self.listingAuthor.text = listing.author;
    if([listing hasThumbnail]) {
        [self.thumbnailView setImageWithURL:[NSURL URLWithString:listing.thumbnail] placeholderImage:[UIImage imageNamed:@"reddit"]];
    } else {
        [self.thumbnailView setImage:[UIImage imageNamed:@"reddit"]];
    }
}

@end

@interface CommentCell()
@property (nonatomic, strong) UILabel *commentText, *commentAuthor;
@property (nonatomic, strong) UIView *cardView;
@end

@implementation CommentCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setupViews];
        [self setupLayout];
    }
    return self;
}

- (void) setupViews {
    [self.cardView addSubview:self.commentText];
    [self.cardView addSubview:self.commentAuthor];
    [self.contentView addSubview:self.cardView];
}

- (void) setupLayout {
    
    [self.cardView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    
    [self.commentAuthor autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.commentAuthor autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.commentAuthor autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.commentAuthor autoSetDimension:ALDimensionHeight toSize:17];
    
    [self.commentText autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.commentAuthor];
    [self.commentText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.commentText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.commentAuthor];
    [self.commentText autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10 relation:NSLayoutRelationGreaterThanOrEqual];
    
    
}

- (void) layoutSubviews {
    [self.contentView layoutSubviews];
    [self setupCard];
}


- (UIView *) cardView {
    if(_cardView) return _cardView;
    _cardView = [[UIView alloc] initForAutoLayout];
    _cardView.backgroundColor = [UIColor whiteColor];
    return _cardView;
}

- (void) setupCard {
    [self.cardView setAlpha:1.0];
    self.cardView.layer.masksToBounds = NO;
    self.cardView.layer.shadowOffset = CGSizeMake(.2f, .2f);
    self.cardView.layer.shadowRadius = 3;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.cardView.bounds, UIEdgeInsetsMake(2, 0, 2, 0))];
    self.cardView.layer.shadowPath = path.CGPath;
    self.cardView.layer.shadowOpacity = 0.2;
}

- (UILabel *) commentAuthor {
    if(_commentAuthor) return _commentAuthor;
    _commentAuthor = [[UILabel alloc] initForAutoLayout];
    _commentAuthor.textColor = [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1.0];
    _commentAuthor.font = [UIFont systemFontOfSize:11.0f];
    _commentAuthor.numberOfLines = 1;
    return _commentAuthor;
}

- (UILabel *) commentText {
    if(_commentText) return _commentText;
    _commentText = [[UILabel alloc] initForAutoLayout];
    _commentText.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1.0];
    _commentText.font = [UIFont systemFontOfSize:13.0f];
    _commentText.numberOfLines = 0;
    return _commentText;
}

- (void) setCellWithComment:(Comment*) comment {
    self.commentAuthor.text = [comment.author isEqualToString:@""] ? @"Anonymous" : comment.author;
    self.commentText.text = comment.body;
}

@end
