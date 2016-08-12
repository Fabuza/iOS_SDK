//
//  UIAlertController+messages.h
//  UsabilityTestRecorder
//
//  Created by Ilya Tarasov on 21.03.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (messages)

+ (void)showAlertFromParent:(UIViewController *)owner withMessage:(NSString *)message;
+ (void)showAlertFromParent:(UIViewController *)owner withMessage:(NSString *)message handler:(dispatch_block_t)handler;

@end
