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

- (UIImage *)imageForRow:(NSUInteger)row
     withCompletionBlock:(void(^)(UIImage *))completionBlock;

@end
