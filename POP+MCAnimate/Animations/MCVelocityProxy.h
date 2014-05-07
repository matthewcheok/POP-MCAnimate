//
//  MCVelocityProxy.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCProxy.h"

@interface NSObject (MCVelocityProxy)

- (instancetype)velocity;
- (void)setVelocity:(id)velocity;

@end

@interface MCVelocityProxy : MCProxy

@property (copy, nonatomic) id velocity;

@end


