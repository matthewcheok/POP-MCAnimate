//
//  MCAnimationGroup.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 3/5/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationGroup.h"
#import "MCAnimationGroupInternal.h"

@interface MCAnimationGroup ()

@property (strong, nonatomic) NSMutableSet *remainingAnimations;
@property (strong, nonatomic) NSMapTable *animationsFinished;

@end

@implementation MCAnimationGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        _remainingAnimations = [NSMutableSet set];
        _animationsFinished = [NSMapTable strongToStrongObjectsMapTable];
    }
    return self;
}

- (void)addAnimation:(POPAnimation *)animation {
    animation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
        for (MCAnimationGroup *group in [NSObject mc_animationGroups]) {
            [group removeAnimation:animation finished:finished];
        }
    };
    
    [self.animationsFinished setObject:@(NO) forKey:animation];
    [self.remainingAnimations addObject:animation];
}

- (void)removeAnimation:(POPAnimation *)animation finished:(BOOL)finished {
    if (![self.remainingAnimations containsObject:animation]) {
        return;
    }
    
    [self.animationsFinished setObject:@(finished) forKey:animation];
    [self.remainingAnimations removeObject:animation];
    
    if ([self.remainingAnimations count] < 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.completionBlock) {
                self.completionBlock([self isFinished]);
            }
            
            [self.animationsFinished removeAllObjects];
        });
    }
}

#pragma mark - Properties

- (BOOL)isFinished {
    for (POPAnimation *animation in self.animationsFinished) {
        if (![[self.animationsFinished objectForKey:animation] boolValue]) {
            return NO;
        }
    }
    return YES;
}

@end

@implementation NSObject (MCAnimationGroup)

+ (void)pop_animate:(void (^)(void))animations completion:(void (^)(BOOL))completion {
    MCAnimationGroup *group = [[MCAnimationGroup alloc] init];
    [[self mc_animationGroups] addObject:group];
    
    __weak MCAnimationGroup *weakGroup = group;
    group.completionBlock = ^(BOOL finished) {
        MCAnimationGroup *strongGroup = weakGroup;
        [[self mc_animationGroups] removeObject:strongGroup];
        
        if (completion) {
            completion(finished);
        }
    };
    
    [self mc_setActiveAnimationGroup:group];
    
    if (animations) {
        animations();
    }
    
    [self mc_setActiveAnimationGroup:nil];
}

@end
