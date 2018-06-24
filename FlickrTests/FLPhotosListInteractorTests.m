//
//  FLPhotosListInteractorTests.m
//  FlickrTests
//
//  Created by Prateek Khandelwal on 6/24/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLPhotosListInteractorOutput.h"
#import "FLPhotosListInteractor.h"

@interface MockOutput : NSObject <FLPhotosListInteractorOutput>

@property (nonatomic) BOOL fetchedPhotosCalled;

@end

@implementation MockOutput

- (void)fetchedPhotos:(NSArray *)photos {
  self.fetchedPhotosCalled = YES;
}

@end


@interface FLPhotosListInteractorTests : XCTestCase

@property (nonatomic) FLPhotosListInteractor *interactor;
@property (nonatomic) MockOutput *output;

@end

@implementation FLPhotosListInteractorTests

- (void)setUp {
  [super setUp];
  _interactor = [FLPhotosListInteractor new];
  _output = [MockOutput new];
  _interactor.output = _output;
}

- (void)tearDown {
  _interactor = nil;
  _output = nil;
  [super tearDown];
}

- (void)testFetchPhotosWithSearchString {
  [self.interactor fetchPhotosWithSearchString:@"kittens" pageNumber:1];
  NSDate *runUntil = [NSDate dateWithTimeIntervalSinceNow:10.0];
  [[NSRunLoop currentRunLoop] runUntilDate:runUntil];
  XCTAssertTrue(self.output.fetchedPhotosCalled);
}

@end
