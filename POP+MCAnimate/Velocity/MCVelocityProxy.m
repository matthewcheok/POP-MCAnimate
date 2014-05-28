//
//  MCVelocityProxy.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCVelocityProxy.h"
#import "MCVelocityProxyInternal.h"

#import <objc/runtime.h>

static char kVelocityProxyKey;

@implementation MCVelocityProxy

+ (NSString *)propertyNameForSelector:(SEL)selector {
    NSString *selectorName = NSStringFromSelector(selector);
    if (![selectorName hasPrefix:@"set"]) {
        [NSException raise:NSInternalInconsistencyException format:@"Spring animation only takes setters."];
    }
    
    NSString *propertyName = [selectorName substringWithRange:NSMakeRange(3, [selectorName length]-4)];
    propertyName = [[[propertyName substringWithRange:NSMakeRange(0, 1)] lowercaseString] stringByAppendingString:[propertyName substringFromIndex:1]];
    
    return propertyName;
}

- (void)completeInvocationWithPropertyName:(NSString *)propertyName andValue:(id)value {
    self.velocity = value;
}

@end

@implementation NSObject (MCVelocityProxyInternal)

- (MCVelocityProxy *)mc_velocityProxy {
    MCVelocityProxy *proxy = objc_getAssociatedObject(self, &kVelocityProxyKey);
	if (!proxy) {
		proxy = [[MCVelocityProxy alloc] initWithObject:self];
		objc_setAssociatedObject(self, &kVelocityProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return proxy;
}

@end

@implementation NSObject (MCVelocityProxy)

- (id)pop_velocity {
    return (id)[self mc_velocityProxy];
}

- (void)setPop_velocity:(id)velocity {
    [self mc_velocityProxy].velocity = velocity;
}

@end