//
//  AppDelegate.m
//  Flickr
//
//  Created by Prateek Khandelwal on 6/22/18.
//  Copyright © 2018 Prateek Khandelwal. All rights reserved.
//

#import "AppDelegate.h"
#import "RootRouter.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  RootRouter *router = [RootRouter new];
  self.window.rootViewController = [router rootViewController];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
