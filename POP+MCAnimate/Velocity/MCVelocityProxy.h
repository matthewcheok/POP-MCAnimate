//
//  MCVelocityProxy.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCProxy.h"


@interface MCVelocityProxy : MCProxy

@property (copy, nonatomic) id velocity;

@end

@interface NSObject (MCVelocityProxy)

- (instancetype)pop_velocity;
- (void)setPop_velocity:(id)velocity;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSObject (MCVelocityProxy_DropPrefix)

- (instancetype)velocity;

@end

@implementation NSObject (MCVelocityProxy_DropPrefix)

MCSHORTHAND_GETTER(velocity, instancetype)
MCSHORTHAND_SETTER(Velocity, velocity, id)

@end

#endif

