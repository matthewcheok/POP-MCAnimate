POP+MCAnimate ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
=============

[![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/POP+MCAnimate/badge.png)](https://github.com/matthewcheok/POP-MCAnimate)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/POP+MCAnimate/badge.svg)](https://github.com/matthewcheok/POP-MCAnimate)

Concise syntax for the [Pop](https://github.com/facebook/pop) animation framework. For more on the motivation behind this experiment, read this [blog post](http://blog.matthewcheok.com/making-your-animations-pop/).

## Installation

Add the following to your [CocoaPods](http://cocoapods.org/) Podfile

    pod 'POP+MCAnimate', '~> 2.0'

or clone as a git submodule,

or just copy files in the ```POP+MCAnimate``` folder into your project.

## Using POP+MCAnimate

**Breaking change:** Methods and properties have been prefixed with *pop_*. See section on shorthand syntax below.

Replace this:

    POPSpringAnimation *animation = [self.boxView pop_animationForKey:@"bounds"];
    if (!animation) {
        animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    }

    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    [self.boxView pop_addAnimation:animation forKey:@"bounds"];

With this:*

    self.boxView.spring.bounds = CGRectMake(0, 0, 200, 200);

### Spring Animation

You can configure `velocity`, `springBounciness` and `springSpeed`.

    self.boxView.velocity.center = [pan velocityInView:self.boxView];
    self.boxView.springBounciness = 20;
    self.boxView.springSpeed = 20;
    self.boxView.spring.center = viewCenter;

### Decay Animation

You can configure `velocity` and `decayDeceleration`.

    self.boxView.velocity.center = [pan velocityInView:self.boxView];
    self.boxView.decayDeceleration = 0.998;
    [self.boxView.decay center];

### Basic Animation

You can configure `duration` and use different timing functions by swapping out `easeInEaseOut` for  `easeIn`, `easeOut` or `linear`.

    self.boxView.duration = 1;
    self.boxView.easeInEaseOut.center = viewCenter;


### Grouping and Completion Handlers

Block-based methods are provided on `NSObject` similar to UIKit block-based animation methods. The `completion` block waits for all animations in the `animate` block to complete before executing.

    [NSObject animate:^{
      self.boxView.spring.alpha = 0.5;
      self.boxView.spring.bounds = CGRectMake(0, 0, 200, 200);
      self.boxView.spring.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
      self.boxView.alpha = 1;
      self.boxView.spring.bounds = CGRectMake(0, 0, 100, 100);
      self.boxView.spring.backgroundColor = [UIColor redColor];
      self.boxView.spring.center = viewCenter;
    }];

If you need to stop animations mid-way, use the stop proxy:

    [self.boxView.stop bounds];

The `finished` flag in the completion handler will return `NO` if any of the animations in the group were stopped before completion.

## Staggering Animations

Big thanks to @borndangerous and @bradjasper for their suggestion on `beginTime`. Great idea from @borndangerous on using sequences.

Set the `beginTime` property before any animations to stagger the animations by the said amount:
```
circle.beginTime = CACurrentMediaTime() + 0.1
circle.spring.alpha = 1;
circle.spring.scaleXY = CGPointMake(1, 1);
```

Once `beginTime` is set, it will persist until removed (by setting to 0), so all animations following that will be affected (which is probably what you want.)

If you work with `NSArrays`, it's even easier using the `-sequenceWithInterval:animations:completion:` method:
```
[circles sequenceWithInterval:0.1 animations:^(UIView *circle, NSInteger index){
    circle.spring.center = position;
    circle.spring.alpha = 1;
    circle.spring.scaleXY = CGPointMake(1, 1);
} completion:^(BOOL finished){
}];
```

## Custom Properties

You can make any property animatable by first declaring it:

    [UILabel registerAnimatablePropertyWithName:@"textColor" readBlock:^(UILabel *label, CGFloat values[]) {
        POPUIColorGetRGBAComponents(label.textColor, values);
    } writeBlock:^(UILabel *label, const CGFloat values[]) {
        label.textColor = POPUIColorRGBACreate(values);
    } threshold:0.01];

You do this by providing a read block, write block and threshold to tell Pop how to get and set numerical values on your property and the smallest increment to change it by. Later, just animate as usual:

    self.messageLabel.spring.textColor = [UIColor blackColor];

## Shorthand*

The above examples require the use of **shorthand** so you can drop the *pop_* prefix from methods and properties. Just include the following in your pre-compiled header file after importing **UIKit**:

    #define MCANIMATE_SHORTHAND
    #import <POP+MCAnimate.h>

## Remarks

The list of supported properties are:
- **CALayer** (and subclasses)
  - backgroundColor
  - bounds
  - opacity
  - position
  - zPosition
  - *pop_*positionX
  - *pop_*positionY
  - *pop_*rotation
  - *pop_*rotationX
  - *pop_*rotationY
  - *pop_*scaleX
  - *pop_*scaleY
  - *pop_*scaleXY
  - *pop_*translationX
  - *pop_*translationXY
  - *pop_*translationY
  - *pop_*translationZ
  - *pop_*size


- **CAShapeLayer**
  - strokeColor
  - strokeStart
  - strokeEnd


- **NSLayoutConstraint**
  - constant


- **UIView** (and subclasses)
  - alpha
  - backgroundColor
  - bounds
  - center
  - frame
  - *pop_*scaleX
  - *pop_*scaleY
  - *pop_*scaleXY


- **UIScrollView** (and subclasses)
  - contentOffset
  - contentSize


## License

POP+MCAnimate is under the MIT license.
