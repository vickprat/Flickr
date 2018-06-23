//
//  FlickrPhoto.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

- (instancetype)initWithID:(NSString *)ID
                    server:(NSString *)server
                      farm:(NSString *)farm
                    secret:(NSString *)secret {
  NSParameterAssert(ID);
  NSParameterAssert(server);
  NSParameterAssert(farm);
  NSParameterAssert(secret);
  self = [super init];
  if (self) {
    _ID = ID;
    _server = server;
    _farm = farm;
    _secret = secret;
  }
  return self;
}

@end
