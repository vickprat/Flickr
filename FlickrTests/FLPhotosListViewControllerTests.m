//
//  FLPhotosListViewControllerTests.m
//  FlickrTests
//
//  Created by Prateek Khandelwal on 6/24/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FLPhotosListCollectionViewController.h"
#import "FLPhotosListViewOutput.h"

@interface MockViewControllerOutput : NSObject <FLPhotosListViewOutput>

@property (nonatomic) BOOL searchButtonPressed;
@property (nonatomic) BOOL scrollEnded;

@end

@implementation MockViewControllerOutput

- (void)searchButtonPressedWithSearchText:(NSString *)searchText {
  self.searchButtonPressed = YES;
}

- (void)scrollWillEnd {
  self.scrollEnded = YES;
}

- (NSUInteger)numberOfPhotos {
  return 1;
}

- (UIImage *)imageForRow:(NSUInteger)row
     withCompletionBlock:(void (^)(UIImage *))completionBlock {
  return [UIImage new];
}

@end

@interface FLPhotosListViewControllerTests : XCTestCase <UISearchBarDelegate>

@property (nonatomic) FLPhotosListCollectionViewController *controller;
@property (nonatomic) MockViewControllerOutput *output;

@end

@implementation FLPhotosListViewControllerTests

- (void)setUp {
  [super setUp];
  _controller = [[FLPhotosListCollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewLayout new]];
  _output = [MockViewControllerOutput new];
  _output.scrollEnded = NO;
  _controller.output = _output;
}

- (void)tearDown {
  _controller = nil;
  _output = nil;
  [super tearDown];
}

- (void)testItemAtIndexPathDelegateMethod {
  XCTAssert([self.output imageForRow:1 withCompletionBlock:nil], @"Image for row method get called");
}

- (void)testNumberOfItemsDelgateMethod {
  XCTAssert([self.output numberOfPhotos], @"Number of photos method get called");
}

- (void)testScrollReachedToEnd {
  [self.controller scrollViewDidScroll:[UIScrollView new]];
  XCTAssertTrue(self.output.scrollEnded);
}

- (void)testSearchButtonClicked {
  [self.controller searchBarSearchButtonClicked:[UISearchBar new]];
  XCTAssertTrue(self.output.searchButtonPressed);
}

@end
