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

@property (assign, nonatomic) CGFloat pop_positionX;
@property (assign, nonatomic) CGFloat pop_positionY;
@property (assign, nonatomic) CGFloat pop_rotation;
@property (assign, nonatomic) CGFloat pop_rotationX;
@property (assign, nonatomic) CGFloat pop_rotationY;
@property (assign, nonatomic) CGFloat pop_scaleX;
@property (assign, nonatomic) CGFloat pop_scaleY;
@property (assign, nonatomic) CGPoint pop_scaleXY;
@property (assign, nonatomic) CGFloat pop_translationX;
@property (assign, nonatomic) CGPoint pop_translationXY;
@property (assign, nonatomic) CGFloat pop_translationY;
@property (assign, nonatomic) CGFloat pop_translationZ;
@property (assign, nonatomic) CGSize  pop_size;

@end

#ifdef MCANIMATE_SHORTHAND

@interface CALayer (MCShorthand_DropPrefix)

@property (assign, nonatomic) CGFloat positionX;
@property (assign, nonatomic) CGFloat positionY;
@property (assign, nonatomic) CGFloat rotation;
@property (assign, nonatomic) CGFloat rotationX;
@property (assign, nonatomic) CGFloat rotationY;
@property (assign, nonatomic) CGFloat scaleX;
@property (assign, nonatomic) CGFloat scaleY;
@property (assign, nonatomic) CGPoint scaleXY;
@property (assign, nonatomic) CGFloat translationX;
@property (assign, nonatomic) CGPoint translationXY;
@property (assign, nonatomic) CGFloat translationY;
@property (assign, nonatomic) CGFloat translationZ;
@property (assign, nonatomic) CGSize  size;

@end

@implementation CALayer (MCShorthand_DropPrefix)

MCSHORTHAND_PROPERTY(positionX,     PositionX,      CGFloat)
MCSHORTHAND_PROPERTY(positionY,     PositionY,      CGFloat)
MCSHORTHAND_PROPERTY(rotation,      Rotation,       CGFloat)
MCSHORTHAND_PROPERTY(rotationX,     RotationX,      CGFloat)
MCSHORTHAND_PROPERTY(rotationY,     RotationY,      CGFloat)
MCSHORTHAND_PROPERTY(scaleX,        ScaleX,         CGFloat)
MCSHORTHAND_PROPERTY(scaleY,        ScaleY,         CGFloat)
MCSHORTHAND_PROPERTY(scaleXY,       ScaleXY,        CGPoint)
MCSHORTHAND_PROPERTY(translationX,  TranslationX,   CGFloat)
MCSHORTHAND_PROPERTY(translationXY, TranslationXY,  CGPoint)
MCSHORTHAND_PROPERTY(translationY,  TranslationY,   CGFloat)
MCSHORTHAND_PROPERTY(translationZ,  TranslationZ,   CGFloat)
MCSHORTHAND_PROPERTY(size,          Size,           CGSize)

@end

#endif
