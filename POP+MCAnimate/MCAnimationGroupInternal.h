//
//  NSObject+MCAnimationGroupInternal.h
//  Pods
//
//  Created by Matthew Cheok on 3/5/14.
//
//

#import "MCAnimationGroup.h"

@interface NSObject (MCAnimationGroupInternal)

+ (NSMutableArray *)mc_animationGroups;
+ (MCAnimationGroup *)mc_activeAnimationGroup;
+ (void)mc_setActiveAnimationGroup:(MCAnimationGroup *)animationGroup;

@end
