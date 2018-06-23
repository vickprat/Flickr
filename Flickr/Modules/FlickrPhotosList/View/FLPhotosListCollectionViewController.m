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

@interface FLPhotosListCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UIScrollViewDelegate>

@property (nonatomic) UIEdgeInsets sectionInsets;
@property (nonatomic) UISearchBar *searchBar;

@end

@implementation FLPhotosListCollectionViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupCollectionView];
  [self setupSearchBar];
}

- (void)setupCollectionView {
  self.sectionInsets = UIEdgeInsetsMake(60, 10, 10, 10);
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

- (void)viewWillLayoutSubviews {
  self.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.frame), 44);
}

- (void)showPhotos {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.collectionView reloadData];
  });
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.output numberOfPhotos];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  FLImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  cell.flickrImageView.image = [self.output imageForRow:indexPath.row];
  if ([self.output imageForRow:indexPath.row] == nil) {
    [[[NSURLSession sharedSession] downloadTaskWithURL:[self.output photoURLForRow:indexPath.row]
                                     completionHandler:^(NSURL *location,
                                                         NSURLResponse *response,
                                                         NSError *error) {
                                       NSData *data = [NSData dataWithContentsOfURL:location];
                                       if (data != nil && error == nil) {
                                         UIImage *image = [UIImage imageWithData:data];
                                         if (image) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                             [self.output cacheImage:image forRow:indexPath.row];
                                             FLImageCollectionViewCell *cell = (FLImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                                             if (cell)
                                               cell.flickrImageView.image = image;
                                           });
                                         } else {
                                           NSLog(@"Corrupted data: %@", data);
                                         }
                                       } else {
                                         NSLog(@"Error in downloading the photo: %@", error);
                                       }
                                     }] resume];
  }
  return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  CGFloat paddingSpace = 4 * self.sectionInsets.left;
  CGFloat availableWidth = collectionView.bounds.size.width - paddingSpace;
  CGFloat widthPerItem = availableWidth / 3;
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
  return self.sectionInsets.left;
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [self.output searchButtonPressedWithSearchText:searchBar.text];
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.collectionView.contentOffset.y + 300 > self.collectionView.contentSize.height - self.collectionView.frame.size.height) {
    [self.output scrollWillEnd];
  }
}

@end
