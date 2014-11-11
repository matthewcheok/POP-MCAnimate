//
//  MCSequenceController.m
//  POP-Demo
//
//  Created by Matthew Cheok on 11/11/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCSequenceController.h"

static NSUInteger const kNumberOfCircles  = 18;
static CGFloat const kCircleRadius     = 50;
static CGFloat const kCircleSize       = 16;

@interface MCSequenceController ()

@property (nonatomic, strong) NSArray *circles;

@end

@implementation MCSequenceController

- (IBAction)handleTap:(id)sender {
	CGFloat angleIncrement = M_PI * 2 / kNumberOfCircles;
	CGPoint center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);

    NSArray *circles = self.circles;
    [circles sequenceWithInterval:0.1 animations:^(UIView *circle, NSInteger index){
        CGPoint position = center;
        position.x += kCircleRadius * sin(angleIncrement * index);
        position.y -= kCircleRadius * cos(angleIncrement * index);

        circle.spring.center = position;
        circle.spring.alpha = 1;
        circle.spring.scaleXY = CGPointMake(1, 1);
    } completion:^(BOOL finished){
        [circles sequenceWithInterval:0 animations:^(UIView *circle, NSInteger index){
            CGPoint position = center;
            position.x += 2 * kCircleRadius * sin(angleIncrement * index);
            position.y -= 2 * kCircleRadius * cos(angleIncrement * index);
            
            circle.spring.center = position;
        } completion:^(BOOL finished){
            [circles sequenceWithInterval:0 animations:^(UIView *circle, NSInteger index){
                CGPoint position = center;
                position.x += 2 * kCircleRadius * sin(angleIncrement * (index-1));
                position.y -= 2 * kCircleRadius * cos(angleIncrement * (index-1));
                
                circle.spring.center = position;
            } completion:^(BOOL finished){
                [circles sequenceWithInterval:0 animations:^(UIView *circle, NSInteger index){
                    CGPoint position = center;
                    position.x += 2 * kCircleRadius * sin(angleIncrement * index);
                    position.y -= 2 * kCircleRadius * cos(angleIncrement * index);
                    
                    circle.spring.center = position;
                } completion:^(BOOL finished){
                    [circles sequenceWithInterval:0.1 animations:^(UIView *circle, NSInteger index){
                        circle.spring.center = center;
                        circle.spring.alpha = 0;
                        circle.spring.scaleXY = CGPointMake(0.5, 0.5);
                    } completion:nil];
                }];
            }];
        }];
    }];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.

	CGPoint center = CGPointMake(CGRectGetWidth(self.view.bounds) / 2, CGRectGetHeight(self.view.bounds) / 2);

	NSMutableArray *circles = [NSMutableArray array];

	for (int i = 0; i < kNumberOfCircles; i++) {
		UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCircleSize, kCircleSize)];
		circle.backgroundColor = [UIColor colorWithRed:0.945 green:0.439 blue:0.416 alpha:1];
		circle.layer.cornerRadius = kCircleSize / 2;
		circle.center = center;
		circle.alpha = 0;
		circle.scaleXY = CGPointMake(0.5, 0.5);

		[self.view addSubview:circle];
		[circles addObject:circle];
	}

	self.circles = [circles copy];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
