//
//  FLImagesListPresenter.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLPhotosListViewOutput.h"
#import "FLPhotosListInteractorOutput.h"

@protocol FLPhotosListViewInput;
@protocol FLPhotosListInteractorInput;

@interface FLPhotosListPresenter : NSObject <FLPhotosListViewOutput, FLPhotosListInteractorOutput>

@property (nonatomic, weak) id <FLPhotosListViewInput> view;
@property (nonatomic, strong) id <FLPhotosListInteractorInput> interactor;

@end
