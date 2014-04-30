POP+MCAnimate ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
=============

[![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/POP+MCAnimate/badge.png)](https://github.com/matthewcheok/POP-MCAnimate)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/POP+MCAnimate/badge.svg)](https://github.com/matthewcheok/POP-MCAnimate)

Concise syntax for the [Pop](https://github.com/facebook/pop) animation framework.

## Installation

Add the following to your [CocoaPods](http://cocoapods.org/) Podfile

    pod 'POP+MCAnimate'

or clone as a git submodule,

or just copy files in the ```POP+MCAnimate``` folder into your project.

## Using POP+MCAnimate

Replace this:

    POPSpringAnimation *animation = [self.boxView pop_animationForKey:@"bounds"];
    if (!animation) {
        animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    }

    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    [self.boxView pop_addAnimation:animation forKey:@"bounds"];

With this:

    self.boxView.spring.bounds = CGRectMake(0, 0, 200, 200);

## Additional Configuration

The animation proxies `spring`, `decay`, `linear`, `easeIn`, `easeOut` and `easeInEaseOut` are provided on `NSObject`. You can set the `toValue` of the animation by setting properties on these proxies.

In addition, there is a `velocity` proxy to take velocities values for spring and decay animations. Velocities expire after one animation. Additional properties `springBounciness` and `springSpeed` are provided on `NSObject` for spring animations and `decayDeceleration` for decay animations.

Because decay animations take no `toValue`, they are created as follows:

    self.boxView.velocity.center = CGPointMake(100, 100);
    [self.boxView.decay center];

## Remarks

Currently only Pop animatable properties that correspond directly to `UIView` and `CALayer` properties are supported.

## License

POP+MCAnimate is under the MIT license.
