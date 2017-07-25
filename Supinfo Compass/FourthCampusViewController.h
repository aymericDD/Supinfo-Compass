//
//  FourthCampusViewController.h
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 16/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Campus.h"

@interface FourthCampusViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property( nonatomic, strong ) Campus *campus;

@end
