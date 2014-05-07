//
//  CALayer+MCShorthand.m
//  Pods
//
//  Created by Matthew Cheok on 4/5/14.
//
//

#import "CALayer+MCShorthand.h"
#import "POPLayerExtras.h"

@implementation CALayer (MCShorthand)

#pragma mark - Position

- (CGFloat)pop_positionX {
    return self.position.x;
}

- (void)setPop_positionX:(CGFloat)pop_positionX {
    CGPoint p = self.position;
    p.x = pop_positionX;
    self.position = p;
}

- (CGFloat)pop_positionY {
    return self.position.y;
}

- (void)setPop_positionY:(CGFloat)pop_positionY {
    CGPoint p = self.position;
    p.y = pop_positionY;
    self.position = p;
}

#pragma mark - Rotation

- (CGFloat)pop_rotation {
    return POPLayerGetRotation(self);
}

- (void)setPop_rotation:(CGFloat)rotation {
    POPLayerSetRotation(self, rotation);
}

- (CGFloat)pop_rotationX {
    return POPLayerGetRotationX(self);
}

- (void)setPop_rotationX:(CGFloat)pop_rotationX {
    POPLayerSetRotationX(self, pop_rotationX);
}

- (CGFloat)pop_rotationY {
    return POPLayerGetRotationY(self);
}

- (void)setPop_rotationY:(CGFloat)pop_rotationY {
    POPLayerSetRotationY(self, pop_rotationY);
}

#pragma mark - Scale

- (CGFloat)pop_scaleX {
    return POPLayerGetScaleX(self);
}

- (void)setPop_scaleX:(CGFloat)pop_scaleX {
    POPLayerSetScaleX(self, pop_scaleX);
}

- (CGFloat)pop_scaleY {
    return POPLayerGetScaleY(self);
}

- (void)setPop_scaleY:(CGFloat)pop_scaleY {
    POPLayerSetScaleY(self, pop_scaleY);
}

- (CGPoint)pop_scaleXY {
    return POPLayerGetScaleXY(self);
}

- (void)setPop_scaleXY:(CGPoint)scaleXY {
    POPLayerSetScaleXY(self, scaleXY);
}

#pragma mark - Translation

- (CGFloat)pop_translationX {
    return POPLayerGetTranslationX(self);
}

- (void)setPop_translationX:(CGFloat)pop_translationX {
    POPLayerSetTranslationX(self, pop_translationX);
}

- (CGPoint)pop_translationXY {
    return POPLayerGetTranslationXY(self);
}

- (void)setPop_translationXY:(CGPoint)pop_translationXY {
    POPLayerSetTranslationXY(self, pop_translationXY);
}

- (CGFloat)pop_translationY {
    return POPLayerGetTranslationY(self);
}

- (void)setPop_translationY:(CGFloat)pop_translationY {
    POPLayerSetTranslationY(self, pop_translationY);
}

- (CGFloat)pop_translationZ {
    return POPLayerGetTranslationZ(self);
}

- (void)setPop_translationZ:(CGFloat)pop_translationZ {
    POPLayerSetTranslationZ(self, pop_translationZ);
}

#pragma mark - Size

- (CGSize)pop_size {
    return [self bounds].size;
}

- (void)setPop_size:(CGSize)size {
    CGRect b = [self bounds];
    b.size = size;
    [self setBounds:b];
}

@end
