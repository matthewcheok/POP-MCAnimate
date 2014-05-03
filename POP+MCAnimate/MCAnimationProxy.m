//
//  MCAnimationProxy.m
//  POPTest
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

- (void)completeInvocationWithPropertyName:(NSString *)propertyName andValue:(id)value {
    // setup animation property
    NSString *popPropertyName = [[[self class] __animationPropertiesForClass:[self.object class]] objectForKey:propertyName];
    
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

+ (NSDictionary *)__animationPropertiesForClass:(Class)class {
	static NSDictionary *animationProperties = nil;
	if (!animationProperties) {
		animationProperties = @{
			@"CALayer": @{
                @"backgroundColor": kPOPLayerBackgroundColor,
				@"bounds": kPOPLayerBounds,
				@"opacity": kPOPLayerOpacity,
				@"position": kPOPLayerPosition,
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
			},

			@"UITableView": @{
				@"contentOffset": kPOPTableViewContentOffset,
				@"contentSize": kPOPTableViewContentSize
			}
		};
	}

	return [animationProperties objectForKey:[class description]];
}

@end
