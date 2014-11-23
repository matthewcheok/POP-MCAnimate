//
//  MCViewController.m
//  POP-Demo
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCViewController.h"

typedef NS_ENUM (NSInteger, MCControllerAnimationType) {
	MCControllerAnimationTypeSpring = 0,
	MCControllerAnimationTypeDecay,
	MCControllerAnimationTypeBasic,
	MCControllerAnimationTypeComplex
};

#import "POPCGUtils.h"

@interface MCViewController () <POPAnimationDelegate>

@property (assign, nonatomic) MCControllerAnimationType type;
@property (weak, nonatomic) IBOutlet UIView *boxView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation MCViewController

- (UIColor *)greatColor {
	switch (self.type) {
		case MCControllerAnimationTypeSpring:
			return [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f];

		case MCControllerAnimationTypeDecay:
			return [UIColor colorWithRed:1.0f green:0.79f blue:0.28f alpha:1.0f];

		case MCControllerAnimationTypeBasic:
			return [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];

		case MCControllerAnimationTypeComplex:
			return [UIColor colorWithRed:0.18f green:0.67f blue:0.84f alpha:1.0f];

		default:
			return [UIColor whiteColor];
	}
}

- (IBAction)typeChanged:(UISegmentedControl *)segmentedControl {
	self.type = segmentedControl.selectedSegmentIndex;

	// move box to center
	CGPoint viewCenter = CGPointMake(CGRectGetMidX(self.view.bounds),
	                                 CGRectGetMidY(self.view.bounds));

	self.boxView.springBounciness = 4;
	self.boxView.springSpeed = 12;
	self.boxView.spring.center = viewCenter;


	switch (self.type) {
		case MCControllerAnimationTypeSpring:
			self.title = @"Spring Animation";
			break;

		case MCControllerAnimationTypeDecay:
			self.title = @"Decay Animation";
			break;

		case MCControllerAnimationTypeBasic:
			self.title = @"Basic Animation";
			break;

		case MCControllerAnimationTypeComplex:
			self.title = @"Complex Animation";
			break;

		default:
			self.title = @"No Animation";
			break;
	}

	UIColor *selectedColor = [self greatColor];
	self.navigationController.navigationBar.easeInEaseOut.barTintColor = selectedColor;
	self.boxView.easeInEaseOut.backgroundColor = selectedColor;
    
    [NSObject animate:^{
        self.messageLabel.spring.textColor = selectedColor;
    } completion:^(BOOL finished) {
        self.messageLabel.spring.textColor = [UIColor blackColor];
    }];
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)pan {
	switch (pan.state) {
		case UIGestureRecognizerStateBegan:
		case UIGestureRecognizerStateChanged: {
			CGPoint translation = [pan translationInView:self.boxView];

			CGPoint center = self.boxView.center;
			center.x += translation.x;
			center.y += translation.y;
			self.boxView.center = center;

			[pan setTranslation:CGPointZero inView:self.boxView];
			break;
		}

		case UIGestureRecognizerStateEnded:
		case UIGestureRecognizerStateCancelled: {
			CGPoint viewCenter = CGPointMake(CGRectGetMidX(self.view.bounds),
			                                 CGRectGetMidY(self.view.bounds));

			switch (self.type) {
				case MCControllerAnimationTypeSpring: {
					self.boxView.velocity.center = [pan velocityInView:self.boxView];
                    self.boxView.pop_delegate = self;
					self.boxView.springBounciness = 20;
					self.boxView.springSpeed = 20;
					self.boxView.spring.center = viewCenter;
					break;
				}

				case MCControllerAnimationTypeDecay: {
					self.boxView.velocity.center = [pan velocityInView:self.boxView];
					[self.boxView.decay center];
					break;
				}

				case MCControllerAnimationTypeBasic: {
					self.boxView.duration = 1;
					self.boxView.easeInEaseOut.center = viewCenter;
					break;
				}

				case MCControllerAnimationTypeComplex: {
					self.boxView.springBounciness = 4;
					self.boxView.springSpeed = 12;
					self.boxView.layer.springBounciness = 1;
					self.boxView.layer.springSpeed = 1;

					UIColor *selectedColor = [self greatColor];
					[NSObject animate: ^{
					    self.boxView.spring.scaleXY = CGPointMake(2, 2);
					    self.boxView.spring.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
					} completion: ^(BOOL finished) {
					    [NSObject animate: ^{
					        self.boxView.layer.spring.rotation = M_PI * 2;
						} completion: ^(BOOL finished) {
                            NSLog(@"finished? %d", finished);
					        self.boxView.spring.scaleXY = CGPointMake(1, 1);
                            self.boxView.spring.backgroundColor = selectedColor;
					        self.boxView.spring.center = viewCenter;
						}];
                        // [self.boxView.layer.stop rotation];
					}];
					break;
				}

				default:
					break;
			}

			break;
		}

		default:
			break;
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

#ifdef MCANIMATE_SHORTHAND
    NSLog(@"shorthand enabled");
#else
    NSLog(@"shorthand disabled");
#endif
    
    // declare custom property
    [UILabel registerAnimatablePropertyWithName:@"textColor" readBlock:^(UILabel *label, CGFloat values[]) {
        POPUIColorGetRGBAComponents(label.textColor, values);
    } writeBlock:^(UILabel *label, const CGFloat values[]) {
        label.textColor = POPUIColorRGBACreate(values);
    } threshold:0.01];
    
	self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
	self.boxView.backgroundColor = [UIColor whiteColor];

	[self typeChanged:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    NSLog(@"delegate stop");
}

@end
