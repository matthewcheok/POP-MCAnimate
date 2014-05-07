//
//  CALayer+MCShorthand.h
//  Pods
//
//  Created by Matthew Cheok on 4/5/14.
//
//

#import <QuartzCore/QuartzCore.h>
#import "MCShorthand.h"

@interface CALayer (MCShorthand)

@property (assign, nonatomic) CGSize  pop_size;
//@property (assign, nonatomic) CGFloat pop_positionX;
//@property (assign, nonatomic) CGFloat pop_positionY;
//@property (assign, nonatomic) CGFloat pop_scaleX;
//@property (assign, nonatomic) CGFloat pop_scaleY;
@property (assign, nonatomic) CGPoint pop_scaleXY;
//@property (assign, nonatomic) CGFloat pop_translationX;
//@property (assign, nonatomic) CGFloat pop_translationY;
//@property (assign, nonatomic) CGFloat pop_translationZ;
//@property (assign, nonatomic) CGPoint pop_translationXY;
@property (assign, nonatomic) CGFloat pop_rotation;
//@property (assign, nonatomic) CGFloat pop_rotationX;
//@property (assign, nonatomic) CGFloat pop_rotationY;

@end

#ifdef MCANIMATE_SHORTHAND

@interface CALayer (MCShorthand_DropPrefix)

@property (assign, nonatomic) CGSize  size;
@property (assign, nonatomic) CGPoint scaleXY;
@property (assign, nonatomic) CGFloat rotation;

@end

@implementation CALayer (MCShorthand_DropPrefix)

MCSHORTHAND_PROPERTY(size, Size, CGSize)
MCSHORTHAND_PROPERTY(scaleXY, ScaleXY, CGPoint)
MCSHORTHAND_PROPERTY(rotation, Rotation, CGFloat)

@end

#endif
