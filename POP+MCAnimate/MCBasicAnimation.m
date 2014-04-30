//
//  MCBasicAnimation.m
//  POPTest
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCBasicAnimation.h"
#import <objc/runtime.h>

static char kBasicAnimationProxyKey;

@implementation NSObject (MCBasicAnimation)

@dynamic duration;

- (MCBasicAnimation *)mc_basicAnimationProxy {
	MCBasicAnimation *proxy = objc_getAssociatedObject(self, &kBasicAnimationProxyKey);
	if (!proxy) {
		proxy = [[MCBasicAnimation alloc] initWithObject:self];
		objc_setAssociatedObject(self, &kBasicAnimationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return proxy;
}

- (CFTimeInterval)duration {
    return [self mc_basicAnimationProxy].duration;
}

- (void)setDuration:(CFTimeInterval)duration {
    [self mc_basicAnimationProxy].duration = duration;
}

- (instancetype)linear {
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    return (id) proxy;
}

- (instancetype)easeIn {
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return (id) proxy;
}

- (instancetype)easeOut {
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return (id) proxy;
}

- (instancetype)easeInEaseOut{
    MCBasicAnimation *proxy = [self mc_basicAnimationProxy];
    proxy.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return (id) proxy;
}

@end

@implementation MCBasicAnimation

- (instancetype)initWithObject:(id)object {
    self = [super initWithObject:object];
    if (self) {
        _duration = 0.4;
    }
    return self;
}

+ (NSString *)propertyNameForSelector:(SEL)selector {
    NSString *selectorName = NSStringFromSelector(selector);
    if (![selectorName hasPrefix:@"set"]) {
        [NSException raise:NSInternalInconsistencyException format:@"Spring animation only takes setters."];
    }
    
    NSString *propertyName = [selectorName substringWithRange:NSMakeRange(3, [selectorName length]-4)];
    propertyName = [[[propertyName substringWithRange:NSMakeRange(0, 1)] lowercaseString] stringByAppendingString:[propertyName substringFromIndex:1]];
    
    return propertyName;
}

- (POPPropertyAnimation *)propertyAnimation {
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.duration = self.duration;
    animation.timingFunction = self.timingFunction;
    return animation;
}

@end