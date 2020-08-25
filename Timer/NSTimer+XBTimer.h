//
//  NSTimer+XBTimer.h
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XBTimerCallbackBlock)(NSTimer *timer);
@interface NSTimer (XBTimer)

+ (NSTimer *)xb_timerWithTimeInterval:(NSTimeInterval)ti target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

+ (NSTimer *)xb_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

+ (NSTimer *)xb_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(nonnull XBTimerCallbackBlock)block;
+ (NSTimer *)xb_scheduledTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(nonnull XBTimerCallbackBlock)block;

@end

NS_ASSUME_NONNULL_END
