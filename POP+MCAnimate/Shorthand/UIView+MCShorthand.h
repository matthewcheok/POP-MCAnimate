//
//  UIView+MCShorthand.h
//  Pods
//
//  Created by Matthew Cheok on 4/5/14.
//
//

#import <UIKit/UIKit.h>
#import "MCShorthand.h"

@interface UIView (MCShorthand)

@property (assign, nonatomic) CGFloat pop_scaleX;
@property (assign, nonatomic) CGFloat pop_scaleY;
@property (assign, nonatomic) CGPoint pop_scaleXY;

@end

#ifdef MCANIMATE_SHORTHAND

@interface UIView (MCShorthand_DropPrefix)

@property (assign, nonatomic) CGFloat scaleX;
@property (assign, nonatomic) CGFloat scaleY;
@property (assign, nonatomic) CGPoint scaleXY;

@end

@implementation UIView (MCShorthand_DropPrefix)

MCSHORTHAND_PROPERTY(scaleX, ScaleX, CGFloat)
MCSHORTHAND_PROPERTY(scaleY, ScaleY, CGFloat)
MCSHORTHAND_PROPERTY(scaleXY, ScaleXY, CGPoint)

@end

#endif
