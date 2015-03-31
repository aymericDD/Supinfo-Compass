//
//  FourthCampusViewController.m
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 16/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import "FourthCampusViewController.h"

@implementation FourthCampusViewController

-(void) viewWillAppear:(BOOL)animated
{
    CLLocationCoordinate2D poiCoordinate;
    poiCoordinate.latitude = [self.campus campusLat];
    poiCoordinate.longitude = [self.campus campusLng];

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoordinate, 750, 750);
    
    [self.mapView setRegion:[self.mapView regionThatFits:viewRegion] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = poiCoordinate;
    point.title = [NSString stringWithFormat:@"Supinfo %@", [self.campus campusName]];
    point.subtitle = [NSString stringWithFormat:@"Address : %@ %i", [self.campus campusRue], [self.campus campusCodePostale]];
    
    [self.mapView addAnnotation:point];
}

@end
