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
    self.boxView.springBounciness = 20;
    self.boxView.springSpeed = 20;
    
    [NSObject animate:^{
        NSLog(@"animating");

        self.boxView.spring.alpha = 0.5;
        self.boxView.spring.bounds = CGRectMake(0, 0, 200, 200);
        self.boxView.spring.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
        NSLog(@"completed finished %d", finished);
        
        self.boxView.alpha = 1;
        self.boxView.spring.bounds = CGRectMake(0, 0, 100, 100);
        self.boxView.spring.backgroundColor = [UIColor redColor];
    }];
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
