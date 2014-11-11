//
//  NSArray+MCSequence.m
//  Pods
//
//  Created by Matthew Cheok on 11/11/14.
//
//

#import "NSArray+MCSequence.h"
#import "MCBeginTime.h"
#import "MCAnimationGroup.h"

#import <UIKit/UIKit.h>

@implementation NSArray (MCSequence)

- (void)pop_sequenceWithInterval:(CFTimeInterval)interval animations:(void (^)(id object, NSInteger index))animations completion:(void (^)(BOOL finished))completion {
    __weak typeof(self) weakSelf = self;
	[NSObject pop_animate: ^{
        typeof(self) strongSelf = weakSelf;
	    for (int i = 0; i < strongSelf.count; i++) {
	        id object = strongSelf[i];
	        [object setPop_beginTime:CACurrentMediaTime() + i * interval];
	        animations(object, i);
		}
	} completion:completion];
}

@end
