//
//  CADisplayLink+XBDisplayLink.h
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XBDisplayLinkCallbackBlock)(CADisplayLink *link);

@interface CADisplayLink (XBDisplayLink)

+ (CADisplayLink *)xb_displayLinkWithTarget:(id)target selector:(SEL)sel;

+ (CADisplayLink *)xb_scheduleDisplayLinkWithTarget:(id)target selector:(SEL)sel;

+ (CADisplayLink *)xb_scheduleDisplayLinkWithBlock:(XBDisplayLinkCallbackBlock)block;


@end

NS_ASSUME_NONNULL_END
