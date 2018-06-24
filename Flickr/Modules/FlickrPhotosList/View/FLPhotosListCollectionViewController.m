//
//  FLImagesListCollectionViewController.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "FLPhotosListCollectionViewController.h"
#import "FLPhotosListViewOutput.h"
#import "FLImageCollectionViewCell.h"

static NSString * const reuseIdentifier = @"FLImageCollectionViewCell";
static NSUInteger const numberOfColumns = 3;
static CGFloat const SearchBarHeight = 44.0;
static CGFloat const SpaceBetweenTwoPhotos = 10.0;

@interface FLPhotosListCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic) UIEdgeInsets sectionInsets;
@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) UIActivityIndicatorView *loadingSpinner;
@property (nonatomic) BOOL isPreviousRequestCompleted;

@end

@implementation FLPhotosListCollectionViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.isPreviousRequestCompleted = YES;
  [self setupCollectionView];
  [self setupSearchBar];
  [self setupLoadingSpinner];
}

- (void)setupCollectionView {
  self.sectionInsets = UIEdgeInsetsMake(SearchBarHeight + SpaceBetweenTwoPhotos,
                                        SpaceBetweenTwoPhotos,
                                        SpaceBetweenTwoPhotos,
                                        SpaceBetweenTwoPhotos);
  UINib *nib = [UINib nibWithNibName:NSStringFromClass([FLImageCollectionViewCell class]) bundle:[NSBundle mainBundle]];
  [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
  self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setupSearchBar {
  self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
  self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
  self.searchBar.delegate = self;
  [self.collectionView addSubview:self.searchBar];
}

- (void)setupLoadingSpinner {
  self.loadingSpinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  self.loadingSpinner.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
  self.loadingSpinner.center = self.collectionView.center;
  [self.collectionView addSubview:self.loadingSpinner];
  [self.loadingSpinner bringSubviewToFront:self.collectionView];
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)viewWillLayoutSubviews {
  self.searchBar.frame = CGRectMake(0,
                                    0,
                                    CGRectGetWidth(self.collectionView.frame),
                                    SearchBarHeight);
}

- (void)showPhotos {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.collectionView reloadData];
    self.isPreviousRequestCompleted = YES;
  });
}

- (void)showLoadingSpinner {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.loadingSpinner startAnimating];
  });
}

- (void)hideLoadingSpinner {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.loadingSpinner stopAnimating];
  });
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.output numberOfPhotos];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  FLImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  cell.flickrImageView.image = [self.output imageForRow:indexPath.row
                                    withCompletionBlock:^(UIImage *image) {
                                      if (image != nil) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                          FLImageCollectionViewCell *cell = (FLImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                                          if (cell && [collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                                            cell.flickrImageView.image = image;
                                          }
                                        });
                                      }
                                    }];
  return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat paddingSpace = (numberOfColumns + 1) * self.sectionInsets.left;
  CGFloat availableWidth = collectionView.bounds.size.width - paddingSpace;
  CGFloat widthPerItem = availableWidth / numberOfColumns;
  return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return self.sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
  return SpaceBetweenTwoPhotos;
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [self.output searchButtonPressedWithSearchText:searchBar.text];
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if ((self.collectionView.contentOffset.y > (self.collectionView.contentSize.height - 2*self.collectionView.frame.size.height)) && self.isPreviousRequestCompleted) {
    [self.output scrollWillEnd];
    self.isPreviousRequestCompleted = NO;
  }
}

@end
