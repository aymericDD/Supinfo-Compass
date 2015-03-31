//
//  ManagerCampus.h
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 08/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Request.h"
#import "Campus.h"


@interface ManagerCampus : UIViewController

@property (nonatomic, strong) NSMutableArray *listCampus;

-(NSMutableArray*) getAllCampus;

-(Campus*) getNearestCampusWithManager:(CLLocationManager*) LocationManager;

@end
