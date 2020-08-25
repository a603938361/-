//
//  XBGCDTimer.m
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import "XBGCDTimer.h"
#import "SLWeakProxy.h"
#import <objc/runtime.h>

@implementation XBGCDTimer

// 定时器创建  但未启动 (block)
+ (XBGCDTimer *)xb_GCDTimerWithStartTime:(NSTimeInterval)start
                                interval:(NSTimeInterval)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats
                                   block:(XBGCDTimerCallbackBlock)block
{
    if (!block || start < 0 || (interval < 0 && repeats)) {
        return nil;
    }
    
    XBGCDTimer *gcdTimer = [[XBGCDTimer alloc] init];
    
    // 创建队列
    dispatch_queue_t queue_t = queue ?: dispatch_get_main_queue();
    // 创建timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue_t);
    // 设置timer
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    objc_setAssociatedObject(gcdTimer, @selector(fire), timer, OBJC_ASSOCIATION_RETAIN);
    
    dispatch_source_set_event_handler(timer, ^{
        block(gcdTimer);
        if (!repeats) {
            [gcdTimer invalidate];
        }
    });
    
    return gcdTimer;
}


// 定时器创建后启动 (block)
+ (XBGCDTimer *)xb_scheduledGCDTimerWithStartTime:(NSTimeInterval)start
                                interval:(NSTimeInterval)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats
                                   block:(XBGCDTimerCallbackBlock)block
{
    XBGCDTimer *gcdTimer = [self xb_GCDTimerWithStartTime:start interval:interval queue:queue repeats:repeats block:block];
    [gcdTimer fire];
    return gcdTimer;
}



// 定时器创建  但未启动 (target)
+ (XBGCDTimer *)xb_GCDTimerWithTarget:(id)target
                                selector:(SEL)selector
                            startTime:(NSTimeInterval)start
                                interval:(NSTimeInterval)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats
{
    SLWeakProxy *proxy = [SLWeakProxy timerProxyWithTarget:target];
    return [self xb_GCDTimerWithStartTime:start interval:interval queue:queue repeats:repeats block:^(XBGCDTimer * _Nonnull timer) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [proxy performSelector:selector];
#pragma clang diagnostic pop
    }];
}


// 定时器创建后启动 (target)
+ (XBGCDTimer *)xb_scheduledGCDTimerWithTarget:(id)target
                                      selector:(SEL)selector
                                     startTime:(NSTimeInterval)start
                                      interval:(NSTimeInterval)interval
                                         queue:(dispatch_queue_t)queue
                                       repeats:(BOOL)repeats
{
    SLWeakProxy *proxy = [SLWeakProxy timerProxyWithTarget:target];
    
    XBGCDTimer *gcdTimer = [self xb_GCDTimerWithStartTime:start interval:interval queue:queue repeats:repeats block:^(XBGCDTimer * _Nonnull timer) {

        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [proxy performSelector:selector];
        #pragma clang diagnostic pop
    }];
    
    [gcdTimer fire];
    return gcdTimer;
}

- (void)fire
{
    dispatch_source_t t = objc_getAssociatedObject(self, _cmd);
    if (t) {
        dispatch_resume(t);
    }
}

- (void)invalidate
{
    dispatch_source_t timer = objc_getAssociatedObject(self, @selector(fire));
    if (timer) {
        dispatch_source_cancel(timer);
    }
    objc_removeAssociatedObjects(self);
}

@end
