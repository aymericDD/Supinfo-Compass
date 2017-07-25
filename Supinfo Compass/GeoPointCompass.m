//
//  GeoPointCompass.m
//  GeoPointCompass
//
//  Created by Maduranga Edirisinghe on 3/27/14.
//  Copyright (c) 2014 Maduranga Edirisinghe. All rights reserved.
//

#import "GeoPointCompass.h"

#define RadiansToDegrees(radians)(radians * 180.0/M_PI)
#define DegreesToRadians(degrees)(degrees * M_PI / 180.0)

float angle;

@implementation GeoPointCompass

- (id) init {
    if(self = [super init]){
        if (self) {
            if ([CLLocationManager headingAvailable] == NO) {
                // No compass is available. This application cannot function without a compass,
                // so a dialog will be displayed and no magnetic data will be measured.
                UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"No Compass!"
                                                                         message:@"This device does not have the ability to measure magnetic fields."
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                [noCompassAlert show];
            }
            self.locationManager = [[CLLocationManager alloc] init];
            if ([CLLocationManager locationServicesEnabled])
            {
                // Configure and start the LocationManager instance
                self.locationManager.delegate = self;
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                self.locationManager.distanceFilter = 100.0f;
                
                 [self.locationManager requestAlwaysAuthorization];
                
                [self.locationManager requestWhenInUseAuthorization];
                
                [self.locationManager startUpdatingLocation];
                [self.locationManager startUpdatingHeading];
            }
        }
    }

    return self;
}

// Caculate the angle between the north and the direction to observed geo-location
-(float)calculateAngle:(CLLocation *)userlocation
{
    float userLocationLatitude = DegreesToRadians(userlocation.coordinate.latitude);
    float userLocationLongitude = DegreesToRadians(userlocation.coordinate.longitude);
    
    float targetedPointLatitude = DegreesToRadians(self.targetCampus.campusLat);
    float targetedPointLongitude = DegreesToRadians(self.targetCampus.campusLng);
    
    float longitudeDifference = targetedPointLongitude - userLocationLongitude;
    
    float y = sin(longitudeDifference) * cos(targetedPointLatitude);
    float x = cos(userLocationLatitude) * sin(targetedPointLatitude) - sin(userLocationLatitude) * cos(targetedPointLatitude) * cos(longitudeDifference);
    float radiansValue = atan2(y, x);
    if(radiansValue < 0.0)
    {
        radiansValue += 2*M_PI;
    }
    
    return radiansValue;
}

#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [self.locationManager startUpdatingLocation];
        [self.locationManager startUpdatingHeading];
        
    } else if (status == kCLAuthorizationStatusAuthorized) {
        
        // iOS 7 will redundantly call this line.
        [self.locationManager startUpdatingLocation];
        [self.locationManager startUpdatingHeading];
        
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        
        UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"Location is not Determined"
                                                                 message:@"You must determined the location to use the compass"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
        [noCompassAlert show];
        [self.locationManager requestAlwaysAuthorization];
    } else if(status == kCLAuthorizationStatusDenied) {
        
        UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"Location is disabled"
                                                                 message:@"You must enable the location to use the compass"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
        [noCompassAlert show];
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"new Location : %@",[newLocation description]);
    angle = [self calculateAngle:newLocation];
    self.targetCampus = [self.manageCampus getNearestCampusWithManager:self.locationManager];
    if ([CLLocationManager headingAvailable] == NO) {
        [self getHeadingForDirection];// Remove this line on real device
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error : %@",[error localizedDescription]);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"New Heading :%@", newHeading);
    
    // !!!! OVERRIDE
    CLLocation *startLocation = manager.location;
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:self.targetCampus.campusLat longitude:self.targetCampus.campusLng];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    self.nameCampusLabel.text = [self.targetCampus campusName];
    self.distanceCampusLabel.text = [NSString stringWithFormat:@"%@ km", [[NSNumber numberWithFloat:(distance)] stringValue]];
    // !!!! END - OVERRIDE
    
    float direction = newHeading.magneticHeading;
    
    if (direction > 180)
    {
        direction = 360 - direction;
    }
    else
    {
        direction = 0 - direction;
    }
    
    // Rotate the arrow image
    if (self.arrowImageView)
    {
        [UIView animateWithDuration:3.0f animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(direction) + angle);
        }];
    }
}


/**
 OVERRIDE
 Force animation when we are on simulator 
 Don't use one Iphone
 */
- (void)getHeadingForDirection
{
    
    float fLat = self.locationManager.location.coordinate.latitude;
    float fLng = self.locationManager.location.coordinate.longitude;
    float tLat = [self.targetCampus campusLat];
    float tLng = [self.targetCampus campusLng];
    
    float degree = RadiansToDegrees(atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng)));
    
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude];
    
    // !!!! OVERRIDE
    CLLocation *startLocation = currentLocation;
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:self.targetCampus.campusLat longitude:self.targetCampus.campusLng];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation] / 1000.f;
    self.nameCampusLabel.text = [self.targetCampus campusName];
    self.distanceCampusLabel.text = [NSString stringWithFormat:@"%.2f km", distance];
    // !!!! END - OVERRIDE
    
    angle = [self calculateAngle:currentLocation];
    
    if(degree<0){
        degree = -degree;
    } else {
        degree = 360 - degree;
    }
    
    NSLog(@"Degree : %f",degree);
    
    // Rotate the arrow image
    if (self.arrowImageView)
    {
        [UIView animateWithDuration:3.0f animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(DegreesToRadians(degree)+ angle);
        }];
    }
}

@end