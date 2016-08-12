//
//  UIAlertController+messages.m
//  UsabilityTestRecorder
//
//  Created by Ilya Tarasov on 21.03.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import "UIAlertController+messages.h"
#import "UIAlertController+Blocks.h"

@implementation UIAlertController (messages)

+ (void)showAlertFromParent:(UIViewController *)owner withMessage:(NSString *)message {
    [UIAlertController showAlertInViewController:owner
                                       withTitle:@"Внимание!"
                                         message:message
                               cancelButtonTitle:@"OK"
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:nil];
}

+ (void)showAlertFromParent:(UIViewController *)owner withMessage:(NSString *)message handler:(dispatch_block_t)handler {
    [UIAlertController showAlertInViewController:owner
                                       withTitle:@"Внимание!"
                                         message:message
                               cancelButtonTitle:@"OK"
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil
                                        tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                            if (handler) {
                                                handler();
                                            }
                                        }];
}

@end
