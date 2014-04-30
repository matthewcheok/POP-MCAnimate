//
//  MCAnimationProxy.h
//  POPTest
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCProxy.h"
#import "MCVelocityProxy.h"

#import <POP.h>

@interface MCAnimationProxy : MCProxy

// subclasses should implement the following methods

+ (NSString *)propertyNameForSelector:(SEL)selector;
- (POPPropertyAnimation *)propertyAnimation;

@end