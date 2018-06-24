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

@interface FLPhotosListInteractor()

@property (nonatomic) FlickrPhotoNetworkService *photoNetworkService;

@end

@implementation FLPhotosListInteractor

- (void)fetchPhotosWithSearchString:(NSString *)searchString
                         pageNumber:(NSUInteger)pageNumber {
  self.photoNetworkService = [[FlickrPhotoNetworkService alloc] init];
  [self.photoNetworkService fetchPhotosWithSearchString:searchString
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

- (void)downloadFlickrPhoto:(FlickrPhoto *)flickrPhoto
        withCompletionBlock:(void (^)(NSData *))completionBlock {
  [self.photoNetworkService downloadPhotoWithFarm:flickrPhoto.farm
                                           server:flickrPhoto.server
                                               ID:flickrPhoto.ID
                                           secret:flickrPhoto.secret
                                  completionBlock:^(NSData *data) {
                                    completionBlock(data);
                                  }];
}

@end
