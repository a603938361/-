//
//  CADisplayLink+XBDisplayLink.m
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import "CADisplayLink+XBDisplayLink.h"
#import "SLWeakProxy.h"
#import <objc/runtime.h>

@implementation CADisplayLink (XBDisplayLink)

+ (CADisplayLink *)xb_displayLinkWithTarget:(id)target selector:(SEL)sel
{
    return [self displayLinkWithTarget:[SLWeakProxy timerProxyWithTarget:target] selector:sel];
}

+ (CADisplayLink *)xb_scheduleDisplayLinkWithTarget:(id)target selector:(SEL)sel
{
    CADisplayLink *link = [self displayLinkWithTarget:[SLWeakProxy timerProxyWithTarget:target] selector:sel];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    return link;
}

+ (CADisplayLink *)xb_scheduleDisplayLinkWithBlock:(XBDisplayLinkCallbackBlock)block
{
    CADisplayLink *link = [self xb_displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
    objc_setAssociatedObject(link, @selector(displayLinkAction:), block, OBJC_ASSOCIATION_COPY);
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    return link;
}



+ (void)displayLinkAction:(CADisplayLink *)link{
    XBDisplayLinkCallbackBlock block = objc_getAssociatedObject(link, _cmd);
    !block?:block(link);
}





@end
