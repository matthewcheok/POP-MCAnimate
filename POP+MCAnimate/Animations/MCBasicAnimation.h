//
//  MCBasicAnimation.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationProxy.h"
#import "MCShorthand.h"

@interface MCBasicAnimation : MCAnimationProxy

@property (assign, nonatomic) CFTimeInterval duration;
@property (strong, nonatomic) CAMediaTimingFunction *timingFunction;

@end

@interface NSObject (MCBasicAnimation)

@property (assign, nonatomic) CFTimeInterval pop_duration;

- (instancetype)pop_linear;
- (instancetype)pop_easeIn;
- (instancetype)pop_easeOut;
- (instancetype)pop_easeInEaseOut;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSObject (MCBasicAnimation_DropPrefix)

@property (assign, nonatomic) CFTimeInterval duration;

- (instancetype)linear;
- (instancetype)easeIn;
- (instancetype)easeOut;
- (instancetype)easeInEaseOut;

@end

@implementation NSObject (MCBasicAnimation_DropPrefix)

MCSHORTHAND_PROPERTY(duration, Duration, CFTimeInterval)
MCSHORTHAND_GETTER(linear, instancetype)
MCSHORTHAND_GETTER(easeIn, instancetype)
MCSHORTHAND_GETTER(easeOut, instancetype)
MCSHORTHAND_GETTER(easeInEaseOut, instancetype)

@end

#endif