//
//  FZTouchVisualizerWindow.h
//  UsabilityTestRecorder
//
//  Created by Ilya Tarasov on 11.02.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//
#include <UIKit/UIKit.h>

@interface FZTouchVisualizerWindow : UIWindow

@property (nonatomic, readonly, getter=isActive) BOOL active;

@property (nonatomic, readonly) NSArray *_Nonnull touches;
@property (nonatomic, readonly) NSUInteger videoSize;

- (void)startRecordScreen:(BOOL)screenRecord andCamera:(BOOL)cameraRecord;
- (void)pauseRecord;
- (void)resumeRecord;
- (void)stopRecordWithProgress:(nullable void (^)(NSProgress * _Nonnull progress))progress
                       success:(nonnull void (^)(NSString * _Nonnull pathToScreenFile, NSString * _Nonnull pathToCameraFile))success
                       failure:(nonnull void (^)(NSError * _Nonnull error))failure;

@end