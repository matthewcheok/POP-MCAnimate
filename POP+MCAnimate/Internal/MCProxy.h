//
//  MCProxy.h
//  POP+MCAnimate
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCProxy : NSProxy

@property (weak, nonatomic, readonly) id object;

- (instancetype)initWithObject:(id)object;

#pragma mark - Required

// subclasses should override the following methods
+ (NSString *)propertyNameForSelector:(SEL)selector;
- (void)completeInvocationWithPropertyName:(NSString *)propertyName andValue:(id)value;

#pragma mark - Utility

+ (NSString *)propertyNameFromSetterSelector:(SEL)selector;
+ (NSString *)propertyNameFromGetterSelector:(SEL)selector;

@end
