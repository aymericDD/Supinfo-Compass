//
//  GeoPointCompass.h
//  GeoPointCompass
//
//  Created by Maduranga Edirisinghe on 3/27/14.
//  Copyright (c) 2014 Maduranga Edirisinghe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Campus.h"
#import "ManagerCampus.h"

@interface GeoPointCompass : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager* locationManager;

@property (nonatomic, retain) UIImageView *arrowImageView;

@property (nonatomic, retain) Campus* targetCampus;

@property (nonatomic, retain) ManagerCampus* manageCampus;

// !!!! OVERRIDE
@property (nonatomic, retain) UILabel *nameCampusLabel;
// Use for set the distance between two points
@property (nonatomic, retain) UILabel *distanceCampusLabel;
// Methode for force animation compass
// !!!!! Don't use it with true Iphone
- (void)getHeadingForDirection;

// !!!! END - OVERRIDE

@end
