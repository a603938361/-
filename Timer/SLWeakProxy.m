//
//  SLWeakProxy.m
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import "SLWeakProxy.h"

@implementation SLWeakProxy

+ (instancetype)timerProxyWithTarget:(id)target
{
    if (!target) {
        return nil;
    }
    
    SLWeakProxy *proxy = [SLWeakProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end
