//
//  MCShorthand.h
//  Pods
//
//  Created by Matthew Cheok on 5/5/14.
//
//

#ifndef Pods_MCShorthand_h
#define Pods_MCShorthand_h

#define MCSHORTHAND_GETTER(getter, ctype) \
- (ctype)getter { \
return [self pop_##getter]; \
}

#define MCSHORTHAND_SETTER(setter, getter, ctype) \
- (void)set ## setter :(ctype)value { \
[self setPop_ ## getter :value]; \
}

#define MCSHORTHAND_PROPERTY(getter, setter, ctype) \
MCSHORTHAND_GETTER (getter, ctype) \
MCSHORTHAND_SETTER (setter, getter, ctype)

#endif
