//
//  MCAnimationGroup.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 3/5/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <POP.h>

@interface MCAnimationGroup : NSObject

@property (assign, nonatomic, getter = isFinished, readonly) BOOL finished;
@property (copy, nonatomic) void (^completionBlock)(BOOL finished);

- (void)addAnimation:(POPAnimation *)animation;
- (void)removeAnimation:(POPAnimation *)animation finished:(BOOL)finished;

@end

@interface NSObject (MCAnimationGroup)

+ (void)pop_animate:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSObject (MCAnimationGroup_DropPrefix)

+ (void)animate:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

@end

@implementation NSObject (MCAnimationGroup_DropPrefix)

+ (void)animate:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
    [self pop_animate:animations completion:completion];
}

@end

#endif
