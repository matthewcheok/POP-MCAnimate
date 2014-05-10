//
//  MCStopProxy.h
//  Pods
//
//  Created by Matthew Cheok on 10/5/14.
//
//

#import "MCProxy.h"
#import "MCShorthand.h"

@interface MCStopProxy : MCProxy

@end

@interface NSObject (MCStopProxy)

- (instancetype)pop_stop;

@end

#ifdef MCANIMATE_SHORTHAND

@interface NSObject (MCStopProxy_DropPrefix)

@property (assign, nonatomic) CFTimeInterval duration;

- (instancetype)stop;

@end

@implementation NSObject (MCStopProxy_DropPrefix)

MCSHORTHAND_GETTER(stop, instancetype)

@end

#endif
