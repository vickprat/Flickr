//
//  FLPhotosListInteractorInput.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlickrPhoto;

@protocol FLPhotosListInteractorInput <NSObject>

- (void)fetchPhotosWithSearchString:(NSString *)searchString
                         pageNumber:(NSUInteger)pageNumber;

- (void)downloadFlickrPhoto:(FlickrPhoto *)flickrPhoto
        withCompletionBlock:(void(^)(NSData *))completionBlock;

@end
