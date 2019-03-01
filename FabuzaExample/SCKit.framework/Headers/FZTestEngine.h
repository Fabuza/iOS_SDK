//
//  FZTestEngine.h
//  UsabilityTestRecorder
//
//  Created by Ilya Tarasov on 28.04.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZTestEngineDataSource.h"
#import "FZTestEngineDelegate.h"

@interface FZTestEngine : NSObject

@property (nonatomic) NSString * _Nonnull pinCode;
@property (nonatomic) BOOL waitBeforeTest;
@property (nonatomic, readonly) BOOL continueTest;
@property (nonatomic, readonly) BOOL isAppTest;
@property (nonatomic, readonly) BOOL isWebTest;
@property (nonatomic, readonly) BOOL isEndTest;
@property (nonatomic) BOOL camBlockedByApp;
@property (nonatomic) BOOL camBlockedByUser;
@property (nonatomic) BOOL micBlockedByUser;
@property (nonatomic, readonly) BOOL needCam;
@property (nonatomic, readonly) BOOL needMic;
@property (nonatomic, readonly) BOOL needLoc;
@property (nonatomic, readonly) BOOL fullScreen;
@property (nonatomic, readonly) BOOL isReadyToTask;
@property (nonatomic, readonly) BOOL isExternalResultUploaded;
@property (nonatomic, readonly) BOOL isOpenFromExternalApp;
@property (nonatomic, assign) id<FZTestEngineDataSource> _Nonnull dataSource;
@property (nonatomic, assign) id<FZTestEngineDelegate> _Nonnull delegate;

@property (nonatomic) BOOL cameraSetupFinished;
@property (nonatomic) BOOL cameraAuthorisationRequired;

/**
	Yes, if 3-2-1 animated sequence was shown
*/
@property (nonatomic, readonly) BOOL animatedStartupShown;

@property (nonatomic) NSURL * _Nullable externalUrl;

+ (instancetype _Nonnull)instance;

// Unified localisation processor - called from loc() macros
+ (NSString * _Nonnull) localizedString:(NSString * _Nonnull)aString;

- (void)on;
- (void)on:(dispatch_block_t _Nullable)complete;
- (void)checkActiveTest;
- (void)continueLastTest;
- (void)beginTest;
- (void)openFabuzaWithParams:(NSDictionary *_Nullable)params;
- (NSString *_Nonnull)getTaskQueryParams;
- (void)stopTaskAndBeginNext;
- (NSString *_Nullable)getCustomJS;
- (NSString *_Nullable)getCustomCSS;
- (BOOL)checkDiscSpace;
- (BOOL)checkLocationEnabled;
- (void)connectedCompletionBlock:(void(^ _Nonnull)(BOOL connected))block;
- (void)dropPushStatus;

// present Animated startup screen 
- (void) showAnimatedStartupWithCompletion:(void (^ __nullable)(void))completion;

// present caera setup
- (void) showCameraSetupWithCompletion:(void (^ __nullable)(void))completion;


- (void) errorAlert:(NSString *_Nonnull) message;


//- (UIViewController *) cameraSetupVC;
@end
