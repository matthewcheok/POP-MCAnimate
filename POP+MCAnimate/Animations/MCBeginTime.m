//
//  NSObject+MCBeginTime.m
//  Pods
//
//  Created by Matthew Cheok on 11/11/14.
//
//

#import "MCBeginTime.h"

#import <objc/runtime.h>

static char kMCAnimateBeginTimeKey;

@implementation NSObject (MCBeginTime)

- (CFTimeInterval)pop_beginTime {
    NSNumber *beginTime = objc_getAssociatedObject(self, &kMCAnimateBeginTimeKey);
    return [beginTime doubleValue];
}

- (void)setPop_beginTime:(CFTimeInterval)beginTime {
    objc_setAssociatedObject(self, &kMCAnimateBeginTimeKey, @(beginTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
