//
//  FlickrTests.m
//  FlickrTests
//
//  Created by Prateek Khandelwal on 6/22/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrPhotoNetworkService.h"

@interface FlickrPhotoNetworkServiceTests : XCTestCase

@end

@implementation FlickrPhotoNetworkServiceTests

- (void)testMovieWebService {
  FlickrPhotoNetworkService *photoNetworkService = [FlickrPhotoNetworkService new];
  XCTestExpectation *expectation = [self expectationWithDescription:@"Photo data not received"];
  [photoNetworkService fetchPhotosWithSearchString:@"kittens"
                                        pageNumber:1
                                   completionBlock:^(NSDictionary *photoData) {
    if (photoData != nil) {
      [expectation fulfill];
    }
  }];
  [self waitForExpectationsWithTimeout:10 handler:nil];
}

@end
