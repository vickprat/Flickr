//
//  FLPhotosListBuilder.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "FLPhotosListBuilder.h"
#import "FLPhotosListCollectionViewController.h"
#import "FLPhotosListPresenter.h"
#import "FLPhotosListInteractor.h"

@implementation FLPhotosListBuilder

- (UIViewController *)build {
  FLPhotosListCollectionViewController *viewController = [[FLPhotosListCollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];

  FLPhotosListPresenter *presenter = [FLPhotosListPresenter new];
  presenter.view = viewController;
  viewController.output = presenter;

  FLPhotosListInteractor *interactor = [FLPhotosListInteractor new];
  interactor.output = presenter;
  presenter.interactor = interactor;

  return viewController;
}

@end
