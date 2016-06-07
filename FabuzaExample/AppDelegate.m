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

@property (nonatomic) FZTestEngine *testEngine;

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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (self.externalUrl) {
        [self initSCKit];
    } else {
        [self openFabuzaWithParams:@{@"bundleId" : [[NSBundle mainBundle] bundleIdentifier]}];
    }
}

#pragma mark - SCKit initialization

- (void)openFabuzaWithParams:(NSDictionary *)params {
    if (self.testEngine == nil) {
        self.testEngine = [FZTestEngine new];
        self.testEngine.dataSource = self;
        self.testEngine.delegate = self;
    }
    [self.testEngine openFabuzaWithParams:params];
}

- (void)initSCKit {
    self.testEngine = [FZTestEngine new];
    self.testEngine.dataSource = self;
    self.testEngine.delegate = self;
    [self.testEngine on];
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
    NSDictionary *params = [self.testEngine parseExternalTestParamsFromUrl:self.externalUrl];
    [self openFabuzaWithParams:params];
}

@end
