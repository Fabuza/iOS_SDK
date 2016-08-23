//
//  FZTestEngine.h
//  UsabilityTestRecorder
//
//  Created by Ilya Tarasov on 28.04.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FZTestEngineDataSource <NSObject>

@required
- (NSUInteger)getVideoFilesSize;

@optional
- (UIViewController *_Nonnull)getRootController;
- (NSArray *_Nonnull)getTouches;
- (NSArray *_Nonnull)getVideoEvents;
- (NSArray *_Nonnull)getCustomNumberEvents;
- (NSArray *_Nonnull)getCustomStringEvents;
- (NSArray *_Nonnull)getRoutes;
- (NSDictionary *_Nonnull)getClientScriptActionEvent;
- (NSURL *_Nullable)getExternalUrl;

@end

@protocol FZTestEngineDelegate <NSObject>

//@required
- (void)startRecordScreen:(BOOL)screenRecord andCamera:(BOOL)cameraRecord;
- (void)stopRecordWithProgress:(nullable void (^)(NSProgress * _Nonnull progress))progress
                       success:(nonnull void (^)(NSString * _Nonnull pathToScreenFile, NSString * _Nonnull pathToCameraFile))success
                       failure:(nonnull void (^)(NSError * _Nonnull error))failure;

@optional
- (void)didLoadUrl:(NSString *_Nullable)urlString;
- (void)didStartApp:(NSDictionary *_Nonnull)params;
- (void)waitForBeginTask:(BOOL)firstStep complete:(dispatch_block_t _Nonnull)complete;
- (void)willBeginProcessName:(NSString *_Nullable)processName;
- (void)doProgressProcess:(CGFloat)progressValue forSize:(NSUInteger)size;
- (void)didEndProcess;
- (void)didEndTest;
- (void)readyForTest;
- (void)didWaitTest;

@end

@interface FZTestEngine : NSObject

@property (nonatomic) NSString * _Nonnull pinCode;
@property (nonatomic, readonly) BOOL continueTest;
@property (nonatomic, readonly) BOOL isAppTest;
@property (nonatomic, readonly) BOOL isWebTest;
@property (nonatomic) BOOL camBlockedByApp;
@property (nonatomic) BOOL camBlockedByUser;
@property (nonatomic) BOOL micBlockedByUser;
@property (nonatomic, readonly) BOOL needCam;
@property (nonatomic, readonly) BOOL needMic;
@property (nonatomic, readonly) BOOL needLoc;
@property (nonatomic, assign) id<FZTestEngineDataSource> _Nonnull dataSource;
@property (nonatomic, assign) id<FZTestEngineDelegate> _Nonnull delegate;

+ (instancetype _Nonnull)instance;

- (void)on;
- (void)continueLastTest;
- (void)beginTest;
- (void)openFabuzaWithParams:(NSDictionary *_Nullable)params;
- (NSDictionary *_Nullable)parseExternalTestParamsFromUrl:(NSURL *_Nullable)url;
- (NSString *_Nonnull)getTaskQueryParams;
- (void)stopTaskAndBeginNext;
- (NSString *_Nullable)getCustomJS;
- (NSString *_Nullable)getCustomCSS;
- (BOOL)checkDiscSpace;
- (BOOL)checkLocationEnabled;
- (void)connectedCompletionBlock:(void(^ _Nonnull)(BOOL connected))block;

@end
