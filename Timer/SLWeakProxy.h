//
//  SLWeakProxy.h
//  Timer
//
//  Created by C.z on 2020/8/25.
//  Copyright © 2020 C.z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLWeakProxy : NSProxy

@property (nonatomic, weak) id target;


+ (instancetype)timerProxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
