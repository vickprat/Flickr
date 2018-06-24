//
//  FLPhotosListBuilderTests.m
//  FlickrTests
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLPhotosListBuilder.h"
#import "FLPhotosListCollectionViewController.h"
#import "FLPhotosListPresenter.h"
#import "FLPhotosListInteractor.h"

@interface FLPhotosListBuilderTests : XCTestCase

@end

@implementation FLPhotosListBuilderTests

- (void)testFLPhotosListBuilder {
  FLPhotosListBuilder *builder = [FLPhotosListBuilder new];
  FLPhotosListCollectionViewController *viewController = (FLPhotosListCollectionViewController *)[builder build];
  XCTAssertNotNil(viewController);
  XCTAssertNotNil(viewController.output);
  
  FLPhotosListPresenter *presenter = (FLPhotosListPresenter *)viewController.output;
  XCTAssertNotNil(presenter.view);
  XCTAssertNotNil(presenter.interactor);
  
  FLPhotosListInteractor *interactor = (FLPhotosListInteractor *)presenter.interactor;
  XCTAssertNotNil(interactor.output);
}

@end
