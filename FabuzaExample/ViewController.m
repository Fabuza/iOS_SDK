//
//  ViewController.m
//  FabuzaExample
//
//  Created by Ilya Tarasov on 23.05.16.
//  Copyright © 2016 Applicatura. All rights reserved.
//

#import "ViewController.h"

#import <SCKit/SCKit.h>


#define BOTTOM_OFFSET	40.0
#define MINIMUM_HEIGHT	15.0

@interface ViewController () {
	double maxHeight;	// maximum height for custom view
}
- (IBAction)backgroundSelectorClicked:(id)sender;
- (IBAction)heightChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIView *customView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	// Setup min/max values for height slider
	CGSize size = [UIScreen mainScreen].bounds.size;
	maxHeight = size.height - self.customView.bounds.size.height - BOTTOM_OFFSET;
	self.slider.minimumValue = MINIMUM_HEIGHT;
	self.slider.maximumValue = maxHeight;
	self.heightConstraint.constant = (maxHeight - MINIMUM_HEIGHT) * 0.5;
	self.slider.value = self.heightConstraint.constant;
	self.customView.backgroundColor = [UIColor greenColor];
    
//    UIViewController *vc = [[FZTestEngine instance] cameraSetupVC];
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
//    
}
    
- (IBAction)backgroundSelectorClicked:(id)sender
{
	UISegmentedControl *ctrl = (UISegmentedControl *)sender;
	switch (ctrl.selectedSegmentIndex) {
		case 0:	self.customView.backgroundColor = [UIColor yellowColor]; break;
		case 1:	self.customView.backgroundColor = [UIColor orangeColor]; break;
		case 2: self.customView.backgroundColor = [UIColor blueColor]; break;
		default:
			self.customView.backgroundColor = [UIColor whiteColor];
	}
}

- (IBAction)heightChanged:(id)sender
{
	self.heightConstraint.constant = self.slider.value;
	
}
@end
