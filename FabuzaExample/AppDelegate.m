//
//  AppDelegate.m
//  FabuzaExample
//
//  Created by Ilya Tarasov on 23.05.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import "AppDelegate.h"
#import <SCKit/SCKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FZTestEngine instance] checkActiveTest];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    [FZTestEngine instance].externalUrl = url;
    [[FZTestEngine instance] on:^{
        NSLog(@"Fabuza Test engine on");
    }];

    return YES;
}

@end
