//
//  MCDecayAnimation.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationProxy.h"
#import "MCShorthand.h"

@interface MCDecayAnimation : MCAnimationProxy

@property (assign, nonatomic) CGFloat deceleration;

@end

@interface NSObject (MCDecayAnimation)

@property (assign, nonatomic) CGFloat pop_decayDeceleration;

- (instancetype)pop_decay;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSObject (MCDecayAnimation_DropPrefix)

@property (assign, nonatomic) CGFloat decayDeceleration;

- (instancetype)decay;

@end

@implementation NSObject (MCDecayAnimation_DropPrefix)

MCSHORTHAND_PROPERTY(decayDeceleration, DecayDeceleration, CGFloat)
MCSHORTHAND_GETTER(decay, instancetype)

@end

#endif