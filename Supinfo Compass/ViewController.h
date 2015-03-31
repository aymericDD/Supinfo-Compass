//
//  ViewController.h
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 08/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GeoPointCompass.h"
#import "ManagerCampus.h"
#import "Campus.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray* listCampus;

@property (weak, nonatomic) IBOutlet UILabel *CampusNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *DistanceCampusLabel;

@property(weak, nonatomic) UIImageView *arrowImageView;

@property (nonatomic, strong) ManagerCampus *managerCampus;

@end

