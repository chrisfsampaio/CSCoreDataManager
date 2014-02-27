//
//  CSAppDelegate.m
//  CSCoreDataStackExample
//
//  Created by Christian Sampaio on 2/27/14.
//  Copyright (c) 2014 Christian Sampaio. All rights reserved.
//

#import "CSAppDelegate.h"

@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
