//
//  MCProxy.m
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCProxy.h"
#import "NSNumber+MCAdditions.h"

@interface MCProxy ()

@property (weak, nonatomic) id object;

@end

@implementation MCProxy

- (instancetype)initWithObject:(id)object {
	_object = object;
	return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
	return [self.object methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
	NSString *propertyName = [[self class] propertyNameForSelector:invocation.selector];
	NSUInteger argumentCount = [[invocation methodSignature] numberOfArguments];
    
	// wrap argument in NSValue/NSNumber if necessary
    id value = nil;
	if (argumentCount > 2) {
        NSMethodSignature *signature = [[self.object class] instanceMethodSignatureForSelector:NSSelectorFromString(propertyName)];
        
        const char *property_type = [signature methodReturnType];
        
		if (!property_type) {
			[NSException raise:NSInternalInconsistencyException format:@"Property '%@' cannot be found on class <%@>.", propertyName, [[self.object class] description]];
		}
        else if ([[NSString stringWithUTF8String:property_type] rangeOfString:@"@"].location != NSNotFound) {
            __unsafe_unretained id argument = nil;
            [invocation getArgument:&argument atIndex:2];
            
            value = argument;
        }
        else {
            NSUInteger bufferSize = 0;
            NSGetSizeAndAlignment(property_type, &bufferSize, NULL);
            void *buffer = malloc(bufferSize);
            
            [invocation getArgument:buffer atIndex:2];
            value = [NSNumber numberWithValue:buffer objCType:property_type];
            
            free(buffer);
        }
	}
    
    [self completeInvocationWithPropertyName:propertyName andValue:value];
}

#pragma mark - Methods

+ (NSString *)propertyNameForSelector:(SEL)selector {
    [NSException raise:NSInternalInconsistencyException format:@"Use a concrete subclass of MCProxy."];
    return nil;
}

- (void)completeInvocationWithPropertyName:(NSString *)propertyName andValue:(id)value {
    [NSException raise:NSInternalInconsistencyException format:@"Use a concrete subclass of MCProxy."];
}

#pragma mark - Utility

+ (NSString *)propertyNameFromSetterSelector:(SEL)selector {
    NSString *selectorName = NSStringFromSelector(selector);
    if (![selectorName hasPrefix:@"set"]) {
        [NSException raise:NSInternalInconsistencyException format:@"%@ only takes setters.", [self description]];
    }
    
    NSString *propertyName = [selectorName substringWithRange:NSMakeRange(3, [selectorName length]-4)];
    propertyName = [[[propertyName substringWithRange:NSMakeRange(0, 1)] lowercaseString] stringByAppendingString:[propertyName substringFromIndex:1]];
    
    return propertyName;
}

+ (NSString *)propertyNameFromGetterSelector:(SEL)selector {
	NSString *selectorName = NSStringFromSelector(selector);
	if ([selectorName hasPrefix:@"set"]) {
		[NSException raise:NSInternalInconsistencyException format:@"%@ only takes setters.", [self description]];
	}
    
	return selectorName;
}

@end
