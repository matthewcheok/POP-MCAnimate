//
//  NSArray+MCSequence.h
//  Pods
//
//  Created by Matthew Cheok on 11/11/14.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (MCSequence)

- (void)pop_sequenceWithInterval:(CFTimeInterval)interval animations:(void (^)(id object, NSInteger index))animations completion:(void (^)(BOOL finished))completion;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSArray (MCSequence_DropPrefix)

- (void)sequenceWithInterval:(CFTimeInterval)interval animations:(void (^)(id object, NSInteger index))animations completion:(void (^)(BOOL finished))completion;

@end

@implementation NSArray (MCSequence_DropPrefix)

- (void)sequenceWithInterval:(CFTimeInterval)interval animations:(void (^)(id object, NSInteger index))animations completion:(void (^)(BOOL finished))completion {
    [self pop_sequenceWithInterval:interval animations:animations completion:completion];
}

@end

#endif
