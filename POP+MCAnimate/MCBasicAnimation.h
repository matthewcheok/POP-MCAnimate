//
//  MCBasicAnimation.h
//  POPTest
//
//  Created by Matthew Cheok on 30/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCAnimationProxy.h"

@interface NSObject (MCBasicAnimation)

@property (assign, nonatomic) CFTimeInterval duration;

- (instancetype)linear;
- (instancetype)easeIn;
- (instancetype)easeOut;
- (instancetype)easeInEaseOut;

@end

@interface MCBasicAnimation : MCAnimationProxy

@property (assign, nonatomic) CFTimeInterval duration;
@property (strong, nonatomic) CAMediaTimingFunction *timingFunction;

@end


