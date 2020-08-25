//
//  XBGCDTimer.h
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XBGCDTimer;
typedef void(^XBGCDTimerCallbackBlock)(XBGCDTimer *timer);

@interface XBGCDTimer : NSObject
// 定时器创建  但未启动 (block)
+ (XBGCDTimer *)xb_GCDTimerWithStartTime:(NSTimeInterval)start
                                interval:(NSTimeInterval)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats
                                   block:(XBGCDTimerCallbackBlock)block;


// 定时器创建后启动 (block)
+ (XBGCDTimer *)xb_scheduledGCDTimerWithStartTime:(NSTimeInterval)start
                                interval:(NSTimeInterval)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats
                                   block:(XBGCDTimerCallbackBlock)block;



// 定时器创建  但未启动 (target)
+ (XBGCDTimer *)xb_GCDTimerWithTarget:(id)target
                                selector:(SEL)selector
                            startTime:(NSTimeInterval)start
                                interval:(NSTimeInterval)interval
                                   queue:(dispatch_queue_t)queue
                                 repeats:(BOOL)repeats;


// 定时器创建后启动 (target)
+ (XBGCDTimer *)xb_scheduledGCDTimerWithTarget:(id)target
                                      selector:(SEL)selector
                                     startTime:(NSTimeInterval)start
                                      interval:(NSTimeInterval)interval
                                         queue:(dispatch_queue_t)queue
                                       repeats:(BOOL)repeats;

- (void)fire;

- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
