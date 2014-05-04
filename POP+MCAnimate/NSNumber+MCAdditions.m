//
//  NSNumber+MCAdditions.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "NSNumber+MCAdditions.h"

@implementation NSNumber (MCAdditions)

+ (instancetype)numberWithValue:(const void *)value objCType:(const char *)type {
	return [[self alloc] initWithValue:value objCType:type];
}

/// For the constants see: <http://developer.apple.com/documentation/Cocoa/Conceptual/ObjectiveC/Articles/chapter_14_section_9.html>
- (instancetype)initWithValue:(const void *)value objCType:(const char *)type {
	if ('^' == *type
	    && nil == *(__unsafe_unretained id *)value) return nil; // nil should stay nil, even if it's technically a (void *)
	id number = [NSNumber alloc];
	switch (*type) {
		case 'c': // BOOL, char
			return [number initWithChar:*(char *)value];

		case 'C': return [number initWithUnsignedChar:*(unsigned char *)value];

		case 's': return [number initWithShort:*(short *)value];

		case 'S': return [number initWithUnsignedShort:*(unsigned short *)value];

		case 'i': return [number initWithInt:*(int *)value];

		case 'I': return [number initWithUnsignedInt:*(unsigned *)value];

		case 'l': return [number initWithLong:*(long *)value];

		case 'L': return [number initWithUnsignedLong:*(unsigned long *)value];

		case 'q': return [number initWithLongLong:*(long long *)value];

		case 'Q': return [number initWithUnsignedLongLong:*(unsigned long long *)value];

		case 'f': return [number initWithFloat:*(float *)value];

		case 'd': return [number initWithDouble:*(double *)value];

		case '@': return *(__unsafe_unretained id *)value;

		case '^': // pointer, no string stuff supported right now
		case '{': // struct, only simple ones containing only basic types right now
		case '[': // array, of whatever, just gets the address
			return (id)[[NSValue alloc] initWithBytes:value objCType:type];
	}

	//NSLog(@"converting unknown format %s", aTypeDescription);
	return (id)[[NSValue alloc] initWithBytes:value objCType:type];
}

@end
