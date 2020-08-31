//
//  ViewController.m
//  DesignPatterns
//
//  Created by C.z on 2020/8/31.
//  Copyright © 2020 C.z. All rights reserved.
//

#import "ViewController.h"
#import "AbstractCar.h"
#import "AbstractRoad.h"
#import "Street.h"
#import "SpeedWay.h"
#import "Car.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AbstractRoad *road = [[SpeedWay alloc] init];
    road.car = [[Car alloc] init];
    [road run];
    

}


@end
