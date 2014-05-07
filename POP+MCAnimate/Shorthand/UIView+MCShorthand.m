//
//  UIView+MCShorthand.m
//  Pods
//
//  Created by Matthew Cheok on 4/5/14.
//
//

#import "UIView+MCShorthand.h"
#import "POPLayerExtras.h"

@implementation UIView (MCShorthand)

- (CGFloat)pop_scaleX {
    return POPLayerGetScaleX(self.layer);
}

- (void)setPop_scaleX:(CGFloat)scaleX {
    POPLayerSetScaleX(self.layer, scaleX);
}

- (CGFloat)pop_scaleY {
    return POPLayerGetScaleY(self.layer);
}

- (void)setPop_scaleY:(CGFloat)scaleY {
    POPLayerSetScaleY(self.layer, scaleY);
}

- (CGPoint)pop_scaleXY {
    return POPLayerGetScaleXY(self.layer);
}

- (void)setPop_scaleXY:(CGPoint)scaleXY {
    POPLayerSetScaleXY(self.layer, scaleXY);
}

@end
