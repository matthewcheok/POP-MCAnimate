//
//  MCViewController.m
//  POP-Demo
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCViewController.h"

#import <POP+MCAnimate.h>

@interface MCViewController ()

@property (weak, nonatomic) IBOutlet UIView *boxView;

@end

@implementation MCViewController {
	BOOL _big;
}

- (IBAction)handleTap:(id)sender {
	_big = !_big;

	self.boxView.springBounciness = 20;
	self.boxView.springSpeed = 20;
	self.boxView.spring.alpha = _big ? 0.7 : 1;
	self.boxView.spring.bounds = _big ? CGRectMake(0, 0, 200, 200) : CGRectMake(0, 0, 100, 100);
	self.boxView.spring.backgroundColor = _big ? [UIColor blueColor] : [UIColor redColor];
    
//    POPSpringAnimation *animation = [self.boxView pop_animationForKey:@"bounds"];
//    if (!animation) {
//        animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
//    }
//    
//    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
//    [self.boxView pop_addAnimation:animation forKey:@"bounds"];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
