//
//  AbstractRoad.h
//  DesignPatterns
//
//  Created by C.z on 2020/8/31.
//  Copyright © 2020 C.z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractCar.h"

NS_ASSUME_NONNULL_BEGIN

@interface AbstractRoad : NSObject

@property (nonatomic, strong) AbstractCar *car;

- (void)run;

@end

NS_ASSUME_NONNULL_END
