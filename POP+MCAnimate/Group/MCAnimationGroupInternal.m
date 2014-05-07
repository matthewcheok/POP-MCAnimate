//
//  NSObject+MCAnimationGroupInternal.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 3/5/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationGroupInternal.h"
#import <objc/runtime.h>

static char kAnimationGroupsKey;
static char kActiveAnimationGroupKey;

@implementation NSObject (MCAnimationGroupInternal)

+ (NSMutableArray *)mc_animationGroups {
    NSMutableArray *array = objc_getAssociatedObject(self, &kAnimationGroupsKey);
	if (!array) {
		array = [NSMutableArray array];
		objc_setAssociatedObject(self, &kAnimationGroupsKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return array;
}

+ (MCAnimationGroup *)mc_activeAnimationGroup {
	return objc_getAssociatedObject(self, &kActiveAnimationGroupKey);
}

+ (void)mc_setActiveAnimationGroup:(MCAnimationGroup *)animationGroup {
	objc_setAssociatedObject(self, &kActiveAnimationGroupKey, animationGroup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
