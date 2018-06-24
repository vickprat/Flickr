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

- (UIImage *)imageForRow:(NSUInteger)row
     withCompletionBlock:(void (^)(UIImage *))completionBlock {
  FlickrPhoto *flickrPhoto = self.photos[row];
  UIImage *image = [self.imageCache objectForKey:flickrPhoto.ID];
  if (image == nil) {
    [self.interactor downloadFlickrPhoto:flickrPhoto
                     withCompletionBlock:^(NSData *data) {
                       if (data != nil) {
                         UIImage *image = [UIImage imageWithData:data];
                         if (image != nil) {
                           if (self.imageCache == nil) {
                             self.imageCache = [NSCache new];
                           }
                           [self.imageCache setObject:image forKey:flickrPhoto.ID];
                         }
                         completionBlock(image);
                       } else {
                         completionBlock(nil);
                       }
                     }];
    return nil;
  } else {
    completionBlock(nil);
    return image;
  }
}

@end
