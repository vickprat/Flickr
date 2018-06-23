//
//  FLPhotosListViewOutput.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FLPhotosListViewOutput <NSObject>

- (void)searchButtonPressedWithSearchText:(NSString *)searchText;

- (void)scrollWillEnd;

- (NSUInteger)numberOfPhotos;

- (NSURL *)photoURLForRow:(NSUInteger)row;

- (void)cacheImage:(UIImage *)image forRow:(NSUInteger)row;

- (UIImage *)imageForRow:(NSUInteger)row;

@end
