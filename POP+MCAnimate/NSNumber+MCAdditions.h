//
//  NSNumber+MCAdditions.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (MCAdditions)

+ (instancetype)numberWithValue:(const void *)value objCType:(const char *)type;
- (instancetype)initWithValue:(const void *)value objCType:(const char *)type;

@end
