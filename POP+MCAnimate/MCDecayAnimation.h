//
//  MCDecayAnimation.h
//  POPTest
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationProxy.h"

@interface NSObject (MCDecayAnimation)

@property (assign, nonatomic) CGFloat decayDeceleration;

- (instancetype)decay;

@end

@interface MCDecayAnimation : MCAnimationProxy

@property (assign, nonatomic) CGFloat deceleration;

@end

