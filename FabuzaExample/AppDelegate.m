//
//  AppDelegate.m
//  FabuzaExample
//
//  Created by Ilya Tarasov on 23.05.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import "AppDelegate.h"
#import "UIAlertController+messages.h"

@interface AppDelegate () <FZTestEngineDataSource, FZTestEngineDelegate>

@end

@implementation AppDelegate

- (FZTouchVisualizerWindow *)window {
    static FZTouchVisualizerWindow *customWindow = nil;
    
    if (!customWindow) {
        customWindow = [[FZTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    return customWindow;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    self.externalUrl = url;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.window pauseRecord];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (self.externalUrl) {
        [self initSCKit];
        [self.window resumeRecord];
    } else {
        [self openFabuzaWithParams:@{@"bundleId" : [[NSBundle mainBundle] bundleIdentifier]}];
    }
}

#pragma mark - SCKit initialization

- (void)openFabuzaWithParams:(NSDictionary *)params {
    [FZTestEngine instance].dataSource = self;
    [FZTestEngine instance].delegate = self;
    [[FZTestEngine instance] openFabuzaWithParams:params];
}

- (void)initSCKit {
    [FZTestEngine instance].dataSource = self;
    [FZTestEngine instance].delegate = self;
    [[FZTestEngine instance] on];
}

#pragma mark - FZTestEngineDataSource

- (NSURL *)getExternalUrl {
    return self.externalUrl;
}

- (NSUInteger)getVideoFilesSize {
    return self.window.videoSize;
}

#pragma mark - FZTestEngineDelegate

- (void)startRecordScreen:(BOOL)screenRecord andCamera:(BOOL)cameraRecord {
    //Для проектов использующих камеру, запись теста с камеры надо выключать так andCamera:NO
    [self.window startRecordScreen:screenRecord andCamera:YES];
}

- (void)stopRecordWithProgress:(void (^)(NSProgress *progress))progress
                       success:(void (^)(NSString *pathToScreenFile, NSString *pathToCameraFile))success
                       failure:(void (^)(NSError *error))failure {
    [self.window stopRecordWithProgress:progress success:success failure:failure];
}

- (void)didEndProcess {
    NSDictionary *params = [[FZTestEngine instance] parseExternalTestParamsFromUrl:self.externalUrl];
    [self openFabuzaWithParams:params];
}

@end
