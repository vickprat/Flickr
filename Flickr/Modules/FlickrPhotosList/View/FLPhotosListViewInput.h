//
//  FLPhotosListViewInput.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLPhotosListViewInput <NSObject>

- (void)showPhotos;

- (void)showLoadingSpinner;

- (void)hideLoadingSpinner;

@end
