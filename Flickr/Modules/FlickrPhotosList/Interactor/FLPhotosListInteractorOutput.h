//
//  FLPhotosListInteractorOutput.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLPhotosListInteractorOutput <NSObject>

- (void)fetchedPhotos:(NSArray *)photos;

@end
