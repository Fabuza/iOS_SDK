//
//  FZTestEngineDataSource.h
//  Fabuza
//
//  Created by Ilya Tarasov on 16.12.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

@protocol FZTestEngineDataSource <NSObject>

@optional
- (UIViewController *_Nonnull)getRootController;
- (NSArray *_Nonnull)getVideoEvents;
- (NSArray *_Nonnull)getCustomNumberEvents;
- (NSArray *_Nonnull)getCustomStringEvents;
- (NSArray *_Nonnull)getRoutes;
- (NSDictionary *_Nonnull)getClientScriptActionEvent;

@end
