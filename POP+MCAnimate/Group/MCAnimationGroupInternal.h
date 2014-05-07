//
//  NSObject+MCAnimationGroupInternal.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 3/5/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationGroup.h"

@interface NSObject (MCAnimationGroupInternal)

+ (NSMutableArray *)mc_animationGroups;
+ (MCAnimationGroup *)mc_activeAnimationGroup;
+ (void)mc_setActiveAnimationGroup:(MCAnimationGroup *)animationGroup;

@end
