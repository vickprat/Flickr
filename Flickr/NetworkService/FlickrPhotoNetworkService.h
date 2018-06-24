//
//  FlickrPhotoNetworkService.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhotoNetworkService : NSObject

- (void)fetchPhotosWithSearchString:(NSString *)searchString
                         pageNumber:(NSUInteger)pageNumber
                    completionBlock:(void (^)(NSDictionary *imageData))completionBlock;

- (void)downloadPhotoWithFarm:(NSString *)farm
                       server:(NSString *)server
                           ID:(NSString *)ID
                       secret:(NSString *)secret
              completionBlock:(void(^)(NSData *data))completionBlock;

@end
