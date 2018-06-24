//
//  FLPhotosListPresenterTests.m
//  FlickrTests
//
//  Created by Prateek Khandelwal on 6/24/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLPhotosListViewInput.h"
#import "FLPhotosListInteractorInput.h"
#import "FLPhotosListPresenter.h"

@interface MockView : UIViewController <FLPhotosListViewInput>

@property (nonatomic) BOOL showingLoadingSpinner;
@property (nonatomic) BOOL photosShown;

@end

@implementation MockView

- (void)showPhotos {
  self.photosShown = YES;
}

- (void)showLoadingSpinner {
  self.showingLoadingSpinner = YES;
}

- (void)hideLoadingSpinner {
  self.showingLoadingSpinner = NO;
}

@end

@interface MockInteractor : NSObject <FLPhotosListInteractorInput>

@property (nonatomic) BOOL isFetchPhotosCalled;
@property (nonatomic) BOOL isDownloadFlickrPhotoCalled;

@end

@implementation MockInteractor

- (void)fetchPhotosWithSearchString:(NSString *)searchString
                         pageNumber:(NSUInteger)pageNumber {
  self.isFetchPhotosCalled = YES;
}

- (void)downloadFlickrPhoto:(FlickrPhoto *)flickrPhoto
        withCompletionBlock:(void (^)(NSData *))completionBlock {
  self.isDownloadFlickrPhotoCalled = YES;
}

@end

@interface FLPhotosListPresenterTests : XCTestCase

@property (nonatomic) FLPhotosListPresenter *presenter;
@property (nonatomic) MockView *mockView;
@property (nonatomic) MockInteractor *mockInteractor;

@end

@implementation FLPhotosListPresenterTests

- (void)setUp {
  [super setUp];
  _presenter = [FLPhotosListPresenter new];
  _mockView = [MockView new];
  _mockInteractor = [MockInteractor new];
  _presenter.view = _mockView;
  _presenter.interactor = _mockInteractor;
}

- (void)tearDown {
  _presenter = nil;
  _mockView = nil;
  _mockInteractor = nil;
  [super tearDown];
}

- (void)testSearchButtonPressedWithEmptySearchText {
  [self.presenter searchButtonPressedWithSearchText:@""];
  XCTAssertFalse(self.mockView.showingLoadingSpinner);
  XCTAssertFalse(self.mockInteractor.isFetchPhotosCalled);
}

- (void)testSearchButtonPressedWithNonEmptySearchText {
  [self.presenter searchButtonPressedWithSearchText:@"kittens"];
  XCTAssertTrue(self.mockView.showingLoadingSpinner);
  XCTAssertTrue(self.mockInteractor.isFetchPhotosCalled);
}

- (void)testScrollWillEndWithEmptySearchText {
  [self.presenter scrollWillEnd];
  XCTAssertFalse(self.mockView.showingLoadingSpinner);
  XCTAssertFalse(self.mockInteractor.isFetchPhotosCalled);
}

- (void)testFetchedPhotos {
  [self.presenter fetchedPhotos:@[]];
  XCTAssertTrue(self.mockView.photosShown);
  XCTAssertFalse(self.mockView.showingLoadingSpinner);
}

- (void)testImageForRow {
  [self.presenter imageForRow:1 withCompletionBlock:nil];
  XCTAssertTrue(self.mockInteractor.isDownloadFlickrPhotoCalled);
}

@end
