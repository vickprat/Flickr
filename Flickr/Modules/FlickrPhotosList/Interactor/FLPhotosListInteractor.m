//
//  FLPhotosListInteractor.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "FLPhotosListInteractor.h"
#import "FlickrPhotoNetworkService.h"
#import "FlickrPhoto.h"
#import "FLPhotosListInteractorOutput.h"

@implementation FLPhotosListInteractor

- (void)fetchPhotosWithSearchString:(NSString *)searchString
                         pageNumber:(NSUInteger)pageNumber {
  FlickrPhotoNetworkService *service = [[FlickrPhotoNetworkService alloc] init];
  [service fetchPhotosWithSearchString:searchString
                            pageNumber:pageNumber
                       completionBlock:^(NSDictionary *imageData) {
                         NSDictionary *photosDict = imageData[@"photos"];
                         NSMutableArray *photos = [[NSMutableArray alloc] init];
                         for (NSDictionary *photo in photosDict[@"photo"]) {
                           FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithID:photo[@"id"]
                                                                               server:photo[@"server"]
                                                                                 farm:photo[@"farm"]
                                                                               secret:photo[@"secret"]];
                           [photos addObject:flickrPhoto];
                         }
                         [self.output fetchedPhotos:photos];
                       }];
}

- (NSURL *)downloadURLForFlickrPhoto:(FlickrPhoto *)flickrPhoto {
  return [NSURL URLWithString:[NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", flickrPhoto.farm, flickrPhoto.server, flickrPhoto.ID, flickrPhoto.secret]];
}

@end
