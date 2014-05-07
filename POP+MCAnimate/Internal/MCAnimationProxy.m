//
//  MCAnimationProxy.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 29/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationProxy.h"
#import "MCAnimationGroupInternal.h"

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

	// setup animation property
	NSString *popPropertyName = [self __popPropertyNameForPropertyName:propertyName];
	if (!popPropertyName) {
		[NSException raise:NSInternalInconsistencyException format:@"Property '%@' is not animatable.", propertyName];
	}

	POPAnimatableProperty *property = [POPAnimatableProperty propertyWithName:popPropertyName];

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

- (NSString *)__popPropertyNameForPropertyName:(NSString *)propertyName {
	static NSDictionary *propertiesByClassName = nil;
	if (!propertiesByClassName) {
		propertiesByClassName = @{
			@"CALayer": @{
				@"backgroundColor": kPOPLayerBackgroundColor,
				@"bounds": kPOPLayerBounds,
				@"opacity": kPOPLayerOpacity,
				@"position": kPOPLayerPosition,
				@"zPosition": kPOPLayerZPosition,
				@"scaleXY": kPOPLayerScaleXY,
				@"size": kPOPLayerSize,
				@"rotation": kPOPLayerRotation,
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
	}


	for (NSString *className in propertiesByClassName) {
		Class class = NSClassFromString(className);

		if (!class || ![self.object isKindOfClass:class]) {
			continue;
		}

		NSDictionary *properties = [propertiesByClassName objectForKey:className];
		NSString *popPropertyName = [properties objectForKey:propertyName];

		if (popPropertyName) {
			return popPropertyName;
		}
	}

	return nil;
}

@end
