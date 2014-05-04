//
//  MCSpringAnimation.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationProxy.h"

@interface NSObject (MCSpringAnimation)

@property (assign, nonatomic) CGFloat springBounciness;
@property (assign, nonatomic) CGFloat springSpeed;

- (instancetype)spring;

@end

@interface MCSpringAnimation : MCAnimationProxy

@property (assign, nonatomic) CGFloat springBounciness;
@property (assign, nonatomic) CGFloat springSpeed;

@end

