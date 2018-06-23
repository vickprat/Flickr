//
//  RootRouter.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "RootRouter.h"
#import "FLPhotosListBuilder.h"

@implementation RootRouter

- (UIViewController *)rootViewController {
  FLPhotosListBuilder *builder = [FLPhotosListBuilder new];
  return [builder build];
}

@end
