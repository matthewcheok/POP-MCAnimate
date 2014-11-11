//
//  NSObject+MCBeginTime.h
//  Pods
//
//  Created by Matthew Cheok on 11/11/14.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (MCBeginTime)

@property (assign, nonatomic) CFTimeInterval pop_beginTime;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSObject (MCBeginTime_DropPrefix)

@property (assign, nonatomic) CFTimeInterval beginTime;

@end

@implementation NSObject (MCBeginTime_DropPrefix)

MCSHORTHAND_PROPERTY(beginTime, BeginTime, CFTimeInterval)

@end

#endif