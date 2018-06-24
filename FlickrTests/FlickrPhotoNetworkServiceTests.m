//
//  FlickrTests.m
//  FlickrTests
//
//  Created by Prateek Khandelwal on 6/22/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlickrPhotoNetworkService.h"
#import "FlickrPhoto.h"

@interface FlickrPhotoNetworkServiceTests : XCTestCase

@property (nonatomic) FlickrPhotoNetworkService *photoNetworkService;

@end

@implementation FlickrPhotoNetworkServiceTests

- (void)setUp {
  [super setUp];
  _photoNetworkService = [FlickrPhotoNetworkService new];
}

- (void)tearDown {
  _photoNetworkService = nil;
  [super tearDown];
}

- (void)testMovieWebServiceForPhotosData {
  XCTestExpectation *expectation = [self expectationWithDescription:@"Photo data not received"];
  [self.photoNetworkService fetchPhotosWithSearchString:@"kittens"
                                             pageNumber:1
                                        completionBlock:^(NSDictionary *photosData) {
                                          if (photosData != nil) {
                                            [expectation fulfill];
                                            [self verifyPhotosData:photosData];
                                          }
                                        }];
  [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)verifyPhotosData:(NSDictionary *)photosData {
  NSDictionary *photosDict = photosData[@"photos"];
  for (NSDictionary *photoDict in photosDict[@"photo"]) {
    XCTAssertNotNil(photoDict[@"server"]);
    XCTAssertNotNil(photoDict[@"farm"]);
    XCTAssertNotNil(photoDict[@"id"]);
    XCTAssertNotNil(photoDict[@"secret"]);
  }
}

@end
