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

- (CGPoint)pop_scaleXY {
    return POPLayerGetScaleXY(self);
}

- (void)setPop_scaleXY:(CGPoint)scaleXY {
    POPLayerSetScaleXY(self, scaleXY);
}

- (CGSize)pop_size {
    return [self bounds].size;
}

- (void)setPop_size:(CGSize)size {
    CGRect b = [self bounds];
    b.size = size;
    [self setBounds:b];
}

- (CGFloat)pop_rotation {
    return POPLayerGetRotation(self);
}

- (void)setPop_rotation:(CGFloat)rotation {
    POPLayerSetRotation(self, rotation);
}

@end
