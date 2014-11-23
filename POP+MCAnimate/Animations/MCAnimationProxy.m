//
//  MCAnimationProxy.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationProxy.h"
#import "MCAnimationGroupInternal.h"

#import <objc/runtime.h>

static char kAnimationDelegateKey;

@implementation MCAnimationProxy

#pragma mark - Methods

+ (NSString *)propertyNameForSelector:(SEL)selector {
	[NSException raise:NSInternalInconsistencyException format:@"Use a concrete subclass of MCAnimationProxy."];
	return nil;
}

- (POPPropertyAnimation *)propertyAnimation {
	[NSException raise:NSInternalInconsistencyException format:@"Use a concrete subclass of MCAnimationProxy."];
	return nil;
}

#pragma mark - Methods

- (void)completeInvocationWithPropertyName:(NSString *)propertyName andValue:(id)value {
	if ([propertyName hasPrefix:@"pop_"]) {
		propertyName = [propertyName substringFromIndex:4];
	}

    // setup property
	POPAnimatableProperty *property = [self __animatablePropertyForPropertyName:propertyName];
    if (!property) {
		[NSException raise:NSInternalInconsistencyException format:@"Property '%@' is not animatable.", propertyName];
	}

	// setup animation
	POPPropertyAnimation *animation = [self.object pop_animationForKey:propertyName];

	if (!animation) {
		animation = [self propertyAnimation];
		animation.property = property;
	}

	if (value) {
		animation.toValue = value;
	}

	MCAnimationGroup *group = [NSObject mc_activeAnimationGroup];
	if (group) {
		[group addAnimation:animation];
	}

	[self.object pop_addAnimation:animation forKey:propertyName];
}

#pragma mark - Private

+ (NSMutableDictionary *)__animatablePropertiesByClassName {
	static NSMutableDictionary *__propertiesByClassName = nil;
	if (!__propertiesByClassName) {
		NSDictionary *mapping = @{
			@"CALayer": @{
				@"backgroundColor": kPOPLayerBackgroundColor,
				@"bounds": kPOPLayerBounds,
				@"opacity": kPOPLayerOpacity,
				@"position": kPOPLayerPosition,
				@"zPosition": kPOPLayerZPosition,

				@"positionX": kPOPLayerPositionX,
				@"positionY": kPOPLayerPositionY,
				@"rotation": kPOPLayerRotation,
				@"rotationX": kPOPLayerRotationX,
				@"rotationY": kPOPLayerRotationY,
				@"scaleX": kPOPLayerScaleX,
				@"scaleY": kPOPLayerScaleY,
				@"scaleXY": kPOPLayerScaleXY,
				@"translationX": kPOPLayerTranslationX,
				@"translationXY": kPOPLayerTranslationXY,
				@"translationY": kPOPLayerTranslationY,
				@"translationZ": kPOPLayerTranslationZ,
				@"size": kPOPLayerSize,
			},

			@"CAShapeLayer": @{
				@"strokeColor": kPOPShapeLayerStrokeColor,
				@"strokeStart": kPOPShapeLayerStrokeStart,
				@"strokeEnd": kPOPShapeLayerStrokeEnd
			},

			@"NSLayoutConstraint": @{
				@"constant": kPOPLayoutConstraintConstant
			},

			@"UIView": @{
				@"alpha": kPOPViewAlpha,
				@"backgroundColor": kPOPViewBackgroundColor,
				@"bounds": kPOPViewBounds,
				@"center": kPOPViewCenter,
				@"frame": kPOPViewFrame,
				@"scaleX": kPOPViewScaleX,
				@"scaleY": kPOPViewScaleY,
				@"scaleXY": kPOPViewScaleXY,
			},

			@"UIScrollView": @{
				@"contentOffset": kPOPScrollViewContentOffset,
				@"contentSize": kPOPScrollViewContentSize
			},

			@"UINavigationBar": @{
				@"barTintColor": kPOPNavigationBarBarTintColor
			},

			@"UIToolbar": @{
				@"barTintColor": kPOPNavigationBarBarTintColor
			},

			@"UITabBar": @{
				@"barTintColor": kPOPTabBarBarTintColor
			},
		};

		__propertiesByClassName = [NSMutableDictionary dictionary];
		for (NSString *className in mapping) {
			__propertiesByClassName[className] = [mapping[className] mutableCopy];
		}
	}

	return __propertiesByClassName;
}

- (POPAnimatableProperty *)__animatablePropertyForPropertyName:(NSString *)propertyName {
    NSDictionary *animatableProperties = [[self class] __animatablePropertiesByClassName];
    
    Class class = [self.object class];
    
    while (class != [NSObject class]) {
        NSString *className = NSStringFromClass(class);
        NSDictionary *classProperties = [animatableProperties objectForKey:className];
        if (classProperties) {
            id property = [classProperties objectForKey:propertyName];
            if ([property isKindOfClass:[NSString class]]) {
                return [POPAnimatableProperty propertyWithName:property];
            }
            else if ([property isKindOfClass:[POPAnimatableProperty class]]) {
                return property;
            }
        }
        
        class = [class superclass];
    }

	return nil;
}

@end

@implementation NSObject (MCAnimationProxy)

- (id)pop_delegate {
    return objc_getAssociatedObject(self, &kAnimationDelegateKey);
}

- (void)setPop_delegate:(id)pop_delegate {
    objc_setAssociatedObject(self, &kAnimationDelegateKey, pop_delegate, OBJC_ASSOCIATION_ASSIGN);
}

+ (void)pop_addAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id, CGFloat *))readBlock writeBlock:(void (^)(id, const CGFloat *))writeBlock threshold:(CGFloat)threshold {
    [self pop_registerAnimatablePropertyWithName:propertyName readBlock:readBlock writeBlock:writeBlock threshold:threshold];
}

+ (void)pop_registerAnimatablePropertyWithName:(NSString *)propertyName readBlock:(void (^)(id, CGFloat *))readBlock writeBlock:(void (^)(id, const CGFloat *))writeBlock threshold:(CGFloat)threshold {
    NSString *className = NSStringFromClass(self);
	NSString *domainName = [NSString stringWithFormat:@"%@.%@", className, propertyName];
	POPAnimatableProperty *property = [POPAnimatableProperty propertyWithName:domainName initializer: ^(POPMutableAnimatableProperty *prop) {
	    prop.readBlock = readBlock;
	    prop.writeBlock = writeBlock;
	    prop.threshold = threshold;
	}];
    
    NSMutableDictionary *animatableProperties = [MCAnimationProxy __animatablePropertiesByClassName];
    
    NSMutableDictionary *classProperties = [animatableProperties objectForKey:className];
    if (!classProperties) {
        classProperties = [NSMutableDictionary dictionary];
        animatableProperties[className] = classProperties;
    }
    
    classProperties[propertyName] = property;
}

@end
