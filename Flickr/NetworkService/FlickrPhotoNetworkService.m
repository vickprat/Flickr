//
//  FlickrPhotoNetworkService.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "FlickrPhotoNetworkService.h"

@implementation FlickrPhotoNetworkService

- (void)fetchPhotosWithSearchString:(NSString *)searchString
                         pageNumber:(NSUInteger)pageNumber
                    completionBlock:(void (^)(NSDictionary *filmData))completionBlock {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&page=%lu&text=%@", (unsigned long)pageNumber, searchString]];
  [[session dataTaskWithURL:url
          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error == nil && data != nil) {
              NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:0
                                                                           error:nil];
              completionBlock(dictionary);
            }
          }] resume];
}

- (void)downloadPhotoWithFarm:(NSString *)farm
                       server:(NSString *)server
                           ID:(NSString *)ID
                       secret:(NSString *)secret
              completionBlock:(void(^)(NSData *data))completionBlock {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@.jpg", farm, server, ID, secret]];
  [[[NSURLSession sharedSession] downloadTaskWithURL:url
                                   completionHandler:^(NSURL *location,
                                                       NSURLResponse *response,
                                                       NSError *error) {
                                     NSData *data = [NSData dataWithContentsOfURL:location];
                                     completionBlock(data);
                                   }] resume];
}

@end
