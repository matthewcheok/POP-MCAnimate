//
//  MCViewController.m
//  POP-Demo
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCViewController.h"
#import <POP+MCAnimate.h>

typedef NS_ENUM(NSInteger, MCControllerAnimationType) {
    MCControllerAnimationTypeSpring = 0,
    MCControllerAnimationTypeDecay,
    MCControllerAnimationTypeBasic,
    MCControllerAnimationTypeComplex
};


@interface MCViewController ()

@property (assign, nonatomic) MCControllerAnimationType type;
@property (weak, nonatomic) IBOutlet UIView *boxView;

@end

@implementation MCViewController

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
                    self.boxView.springBounciness = 20;
                    self.boxView.springSpeed = 20;
                    
                    self.boxView.velocity.center = [pan velocityInView:self.boxView];
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
                    
                    [NSObject animate:^{
                        self.boxView.spring.alpha = 0.5;
                        self.boxView.spring.bounds = CGRectMake(0, 0, 200, 200);
                        self.boxView.spring.backgroundColor = [UIColor blueColor];
                    } completion:^(BOOL finished) {
                        self.boxView.alpha = 1;
                        self.boxView.spring.bounds = CGRectMake(0, 0, 100, 100);
                        self.boxView.spring.backgroundColor = [UIColor redColor];
                        self.boxView.spring.center = viewCenter;
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
    
    [self typeChanged:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
