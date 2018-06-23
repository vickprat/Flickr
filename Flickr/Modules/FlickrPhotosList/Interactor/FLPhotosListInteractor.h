//
//  FLPhotosListInteractor.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLPhotosListInteractorInput.h"

@protocol FLPhotosListInteractorOutput;

@interface FLPhotosListInteractor : NSObject <FLPhotosListInteractorInput>

@property (nonatomic, weak) id <FLPhotosListInteractorOutput> output;

@end
