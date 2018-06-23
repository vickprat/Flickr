//
//  FLImagesListCollectionViewController.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLPhotosListViewInput.h"

@protocol FLPhotosListViewOutput;

@interface FLPhotosListCollectionViewController : UICollectionViewController <FLPhotosListViewInput>

@property (nonatomic, strong) id <FLPhotosListViewOutput> output;

@end
