//
//  MCAnimationProxy.h
//  POP+MCAnimate
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

@interface NSObject (MCAnimationProxy)

+ (void)pop_addAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id obj, CGFloat values[]))readBlock writeBlock:(void (^)(id obj, const CGFloat values[]))writeBlock threshold:(CGFloat)threshold __attribute__((deprecated));
+ (void)pop_registerAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id obj, CGFloat values[]))readBlock writeBlock:(void (^)(id obj, const CGFloat values[]))writeBlock threshold:(CGFloat)threshold;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSObject (MCAnimationProxy_DropPrefix)

+ (void)addAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id obj, CGFloat values[]))readBlock writeBlock:(void (^)(id obj, const CGFloat values[]))writeBlock threshold:(CGFloat)threshold __attribute__((deprecated));
+ (void)registerAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id obj, CGFloat values[]))readBlock writeBlock:(void (^)(id obj, const CGFloat values[]))writeBlock threshold:(CGFloat)threshold;

@end

@implementation NSObject (MCAnimationProxy_DropPrefix)

+ (void)addAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id obj, CGFloat values[]))readBlock writeBlock:(void (^)(id obj, const CGFloat values[]))writeBlock threshold:(CGFloat)threshold {
    [self pop_registerAnimatablePropertyWithName:propertyName readBlock:readBlock writeBlock:writeBlock threshold:threshold];
}

+ (void)registerAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id obj, CGFloat values[]))readBlock writeBlock:(void (^)(id obj, const CGFloat values[]))writeBlock threshold:(CGFloat)threshold {
    [self pop_registerAnimatablePropertyWithName:propertyName readBlock:readBlock writeBlock:writeBlock threshold:threshold];
}

@end

#endif