//
//  ViewController.m
//  FabuzaExample
//
//  Created by Ilya Tarasov on 23.05.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController () //<FZTestEngineDataSource, FZTestEngineDelegate>

//@property (strong, nonatomic) FZTestEngine *testEngine;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    AppDelegate *appDelegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
//    
//    if (appDelegate.externalUrl) {
//        [self initSCKit];
//    } else {
//        [self openFabuzaWithParams:@{@"bundleId" : [[NSBundle mainBundle] bundleIdentifier]}];
//    }
}

//- (void)openFabuzaWithParams:(NSDictionary *)params {
//    self.testEngine = [FZTestEngine new];
//    self.testEngine.dataSource = self;
//    self.testEngine.delegate = self;
//    [self.testEngine openFabuzaWithParams:params];
//}
//
//#pragma mark - SCKit initialization
//
//- (void)initSCKit {
//    self.testEngine = [FZTestEngine new];
//    self.testEngine.dataSource = self;
//    self.testEngine.delegate = self;
//    [self.testEngine on];
//}

//#pragma mark - FZTestEngineDataSource
//
//- (NSURL *)getExternalUrl {
//    AppDelegate *appDelegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
//    return appDelegate.externalUrl;
//}
//
//- (UIViewController *)getRootController {
//    return self;
//}
//
//- (NSUInteger)getVideoSize {
//    AppDelegate *appDelegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
//    return appDelegate.window.videoSize;
//}
//
//#pragma mark - FZTestEngineDelegate
//
//- (void)startRecordScreen:(BOOL)screenRecord andCamera:(BOOL)cameraRecord {
//    AppDelegate *appDelegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
//    
//    [appDelegate.window startRecordScreen:screenRecord andCamera:cameraRecord];
//}
//
//- (void)stopRecordWithProgress:(void (^)(NSProgress *progress))progress
//                       success:(void (^)(NSString *pathToScreenFile, NSString *pathToCameraFile))success
//                       failure:(void (^)(NSError *error))failure {
//    AppDelegate *appDelegate = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
//    [appDelegate.window stopRecordWithProgress:progress success:success failure:failure];
//}

@end
