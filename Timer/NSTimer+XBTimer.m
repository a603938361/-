//
//  NSTimer+XBTimer.m
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import "NSTimer+XBTimer.h"
#import "SLWeakProxy.h"
#import <objc/runtime.h>

@implementation NSTimer (XBTimer)

+ (NSTimer *)xb_timerWithTimeInterval:(NSTimeInterval)ti target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    return [self timerWithTimeInterval:ti target:target selector:selector userInfo:userInfo repeats:yesOrNo];
}

+ (NSTimer *)xb_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    return [self scheduledTimerWithTimeInterval:ti target:[SLWeakProxy timerProxyWithTarget:target] selector:selector userInfo:userInfo repeats:yesOrNo];
}

+ (NSTimer *)xb_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(nonnull XBTimerCallbackBlock)block
{
    if (!block) {
        return nil;
    }
    
    NSTimer *timer = [self timerWithTimeInterval:interval target:[SLWeakProxy timerProxyWithTarget:self] selector:@selector(_blockAction:) userInfo:nil repeats:repeats];
    if (!timer) {
        return timer;
    }
    
    objc_setAssociatedObject(timer, @selector(_blockAction:), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return timer;
}

+ (NSTimer *)xb_scheduledTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(nonnull XBTimerCallbackBlock)block
{
    if (!block) {
        return nil;
    }
    
    NSTimer *timer = [self scheduledTimerWithTimeInterval:interval target:[SLWeakProxy timerProxyWithTarget:self] selector:@selector(_blockAction:) userInfo:nil repeats:repeats];
    if (!timer) {
        return timer;
    }
    
    objc_setAssociatedObject(timer, @selector(_blockAction:), block, OBJC_ASSOCIATION_COPY);
    return timer;
}

+ (void)_blockAction:(NSTimer*)timer{
    XBTimerCallbackBlock block = objc_getAssociatedObject(timer, _cmd);
    !block?:block(timer);
}



@end
