//
//  FLPhotosListPresenter.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "FLPhotosListPresenter.h"
#import "FLPhotosListInteractorInput.h"
#import "FLPhotosListViewInput.h"
#import "FlickrPhoto.h"

@interface FLPhotosListPresenter()

@property (nonatomic) NSString *searchText;
@property (nonatomic) NSArray *photos;
@property (nonatomic) NSCache *imageCache;
@property (nonatomic) NSUInteger pageNumber;

@end

@implementation FLPhotosListPresenter

- (void)searchButtonPressedWithSearchText:(NSString *)searchText {
  if ([self shouldFetchPhotosForSearchText:searchText]) {
    self.pageNumber = 1;
    self.searchText = searchText;
    [self.interactor fetchPhotosWithSearchString:self.searchText
                                      pageNumber:self.pageNumber];
    [self.view showLoadingSpinner];
  }
}

- (void)scrollWillEnd {
  if ([self shouldFetchPhotosForSearchText:self.searchText]) {
    self.pageNumber++;
    [self.interactor fetchPhotosWithSearchString:self.searchText
                                      pageNumber:self.pageNumber];
    [self.view showLoadingSpinner];
  }
}

- (BOOL)shouldFetchPhotosForSearchText:(NSString *)searchText {
  return searchText != nil && ![searchText isEqualToString:@""];
}

- (NSUInteger)numberOfPhotos {
  return [self.photos count];
}

- (void)fetchedPhotos:(NSArray *)photos {
  if (self.pageNumber == 1) {
    self.photos = photos;
  } else {
    self.photos = [[self.photos mutableCopy] arrayByAddingObjectsFromArray:photos];
  }
  [self.view showPhotos];
  [self.view hideLoadingSpinner];
}

- (NSURL *)photoURLForRow:(NSUInteger)row {
  FlickrPhoto *flickrPhoto = self.photos[row];
  return [self.interactor downloadURLForFlickrPhoto:flickrPhoto];
}

- (void)cacheImage:(UIImage *)image forRow:(NSUInteger)row {
  FlickrPhoto *flickrPhoto = self.photos[row];
  [self.imageCache setObject:image forKey:flickrPhoto.ID];
}

- (UIImage *)imageForRow:(NSUInteger)row {
  FlickrPhoto *flickrPhoto = self.photos[row];
  return [self.imageCache objectForKey:flickrPhoto.ID];
}

@end
