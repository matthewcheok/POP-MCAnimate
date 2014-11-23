//
//  MCSpringAnimation.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCSpringAnimation.h"
#import "MCVelocityProxyInternal.h"

#import <objc/runtime.h>

static char kSpringAnimationProxyKey;

@implementation MCSpringAnimation

- (instancetype)initWithObject:(id)object {
    self = [super initWithObject:object];
    if (self) {
        _springBounciness = 4;
        _springSpeed = 12;
    }
    return self;
}

+ (NSString *)propertyNameForSelector:(SEL)selector {
    return [self propertyNameFromSetterSelector:selector];
}

- (POPPropertyAnimation *)propertyAnimation {
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.springBounciness = self.springBounciness;
    animation.springSpeed = self.springSpeed;
    
    id velocity = [self.object mc_velocityProxy].velocity;
	if (velocity) {
		animation.velocity = velocity;
        [self.object mc_velocityProxy].velocity = nil;
	}
    
    animation.beginTime = [self.object pop_beginTime];
    animation.delegate = [self.object pop_delegate];
    [self.object setPop_delegate:nil];
    
    return animation;
}

@end

@implementation NSObject (MCSpringAnimation)

- (MCSpringAnimation *)mc_springAnimationProxy {
	MCSpringAnimation *proxy = objc_getAssociatedObject(self, &kSpringAnimationProxyKey);
	if (!proxy) {
		proxy = [[MCSpringAnimation alloc] initWithObject:self];
		objc_setAssociatedObject(self, &kSpringAnimationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return proxy;
}

- (instancetype)pop_spring {
	return (id) [self mc_springAnimationProxy];
}

- (CGFloat)pop_springBounciness {
    return [self mc_springAnimationProxy].springBounciness;
}

- (void)setPop_springBounciness:(CGFloat)springBounciness {
    [self mc_springAnimationProxy].springBounciness = springBounciness;
}

- (CGFloat)pop_springSpeed {
    return [self mc_springAnimationProxy].springSpeed;
}

- (void)setPop_springSpeed:(CGFloat)springSpeed {
    [self mc_springAnimationProxy].springSpeed = springSpeed;
}

@end
