//
//  FlickrPhoto.h
//  Flickr
//
//  Created by Prateek Khandelwal on 6/23/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject

- (instancetype)initWithID:(NSString *)ID
                    server:(NSString *)server
                      farm:(NSString *)farm
                    secret:(NSString *)secret;

@property (nonatomic, readonly) NSString *farm;
@property (nonatomic, readonly) NSString *server;
@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *secret;

@end
