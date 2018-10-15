//
//  FZTestEngineDelegate.h
//  Fabuza
//
//  Created by Ilya Tarasov on 16.12.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

@protocol FZTestEngineDelegate <NSObject>

@optional
- (void)startRecordScreen:(NSUInteger)screenRecord andCamera:(NSUInteger)cameraRecord;
- (void)stopRecordWithProgress:(nullable void (^)(NSProgress * _Nonnull progress))progress
                       success:(nonnull void (^)(NSString * _Nonnull pathToScreenFile, NSString * _Nonnull pathToCameraFile))success
                       failure:(nonnull void (^)(NSError * _Nonnull error))failure;

- (void)didLoadUrl:(NSString *_Nullable)urlString;
- (void)didStartApp:(NSDictionary *_Nonnull)params;
- (void)waitForBeginTask:(BOOL)firstStep complete:(dispatch_block_t _Nonnull)complete;
- (void)willBeginProcessName:(NSString *_Nullable)processName;
- (void)doProgressProcess:(CGFloat)progressValue forSize:(NSUInteger)size;
- (void)didEndProcess;
- (void)didEndTest;
- (void)readyForTest;
- (void)didWaitTest;
- (void)didBeginTask;

@end
