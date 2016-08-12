//
//  AppDelegate.h
//  FabuzaExample
//
//  Created by Ilya Tarasov on 23.05.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SCKit/SCKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) FZTouchVisualizerWindow *window;
@property (nonatomic) NSURL *externalUrl;

@end

