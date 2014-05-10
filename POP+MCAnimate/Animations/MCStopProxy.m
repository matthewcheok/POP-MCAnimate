//
//  MCStopProxy.m
//  Pods
//
//  Created by Matthew Cheok on 10/5/14.
//
//

#import "MCStopProxy.h"

#import <POP.h>
#import <objc/runtime.h>

static char kStopAnimationProxyKey;

@implementation MCStopProxy

+ (NSString *)propertyNameForSelector:(SEL)selector {
    return [self propertyNameFromGetterSelector:selector];
}

- (void)completeInvocationWithPropertyName:(NSString *)propertyName andValue:(id)value {
	if ([propertyName hasPrefix:@"pop_"]) {
		propertyName = [propertyName substringFromIndex:4];
	}
    
	// remove animation
	POPPropertyAnimation *animation = [self.object pop_animationForKey:propertyName];
	if (animation) {
		[self.object pop_removeAnimationForKey:propertyName];
	}
}

@end

@implementation NSObject (MCStopProxy)

- (MCStopProxy *)mc_stopAnimationProxy {
	MCStopProxy *proxy = objc_getAssociatedObject(self, &kStopAnimationProxyKey);
	if (!proxy) {
		proxy = [[MCStopProxy alloc] initWithObject:self];
		objc_setAssociatedObject(self, &kStopAnimationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return proxy;
}

- (instancetype)pop_stop {
	return (id)[self mc_stopAnimationProxy];
}

@end