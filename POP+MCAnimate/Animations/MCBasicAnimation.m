//
//  MCBasicAnimation.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCBasicAnimation.h"
#import <objc/runtime.h>

static char kBasicAnimationProxyKey;

@implementation MCBasicAnimation

- (instancetype)initWithObject:(id)object {
    self = [super initWithObject:object];
    if (self) {
        _duration = 0.4;
    }
    return self;
}

+ (NSString *)propertyNameForSelector:(SEL)selector {
    return [self propertyNameFromSetterSelector:selector];
}

- (POPPropertyAnimation *)propertyAnimation {
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.duration = self.duration;
    animation.timingFunction = self.timingFunction;
    
    animation.beginTime = [self.object pop_beginTime];
    animation.delegate = [self.object pop_delegate];
    [self.object setPop_delegate:nil];

    return animation;
}

@end

@implementation NSObject (MCBasicAnimation)

- (MCBasicAnimation *)mc_basicAnimationProxy {
	MCBasicAnimation *proxy = objc_getAssociatedObject(self, &kBasicAnimationProxyKey);
	if (!proxy) {
		proxy = [[MCBasicAnimation alloc] initWithObject:self];
		objc_setAssociatedObject(self, &kBasicAnimationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return proxy;
}

- (CFTimeInterval)pop_duration {
    return [self mc_basicAnimationProxy].duration;
}

- (void)setPop_duration:(CFTimeInterval)duration {
    [self mc_basicAnimationProxy].duration = duration;
}

- (instancetype)pop_linear {
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return (id) proxy;
}

- (instancetype)pop_easeIn {
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return (id) proxy;
}

- (instancetype)pop_easeOut {
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return (id) proxy;
}

- (instancetype)pop_easeInEaseOut{
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return (id) proxy;
}

@end