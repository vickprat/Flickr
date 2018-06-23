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
                         NSDictionary *photosDictionary = imageData[@"photos"];
                         NSMutableArray *photos = [[NSMutableArray alloc] init];
                         for (NSDictionary *photoDictionary in photosDictionary[@"photo"]) {
                           [photos addObject:[self flickrPhotoFromPhotoDictionary:photoDictionary]];
                         }
                         [self.output fetchedPhotos:photos];
                       }];
}

- (FlickrPhoto *)flickrPhotoFromPhotoDictionary:(NSDictionary *)photoDictionary {
  return [[FlickrPhoto alloc] initWithID:photoDictionary[@"id"]
                                  server:photoDictionary[@"server"]
                                    farm:photoDictionary[@"farm"]
                                  secret:photoDictionary[@"secret"]];
}

- (NSURL *)downloadURLForFlickrPhoto:(FlickrPhoto *)flickrPhoto {
  return [NSURL URLWithString:[NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", flickrPhoto.farm, flickrPhoto.server, flickrPhoto.ID, flickrPhoto.secret]];
}

@end
