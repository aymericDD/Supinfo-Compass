//
//  ManagerCampus.m
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 08/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import "ManagerCampus.h"

@implementation ManagerCampus

@synthesize listCampus;

-(id) init
{
    self.listCampus = [[NSMutableArray alloc] init];
    return self;
}

-(NSMutableArray*) getAllCampus
{
    [self.listCampus removeAllObjects];
    // Get class request
    Request *cls_Request = [[Request alloc] init];
    
    NSArray *campuses = [cls_Request getDataByUrl:@"http://dev.api-campus.com/api/campus/all"];
    
    // Iterate through the object and print desired results
    for(NSObject *st in campuses) {
        // Localisation
        NSObject *localisation = [st valueForKey:@"localisation"];
        float lat = [[localisation valueForKey:@"lat"] floatValue];
        float lng = [[localisation valueForKey:@"lng"] floatValue];
        // Adresse
        NSObject *address = [st valueForKey:@"address"];
        NSString *rue = [address valueForKey:@"rue"];
        int postalCode = [[address valueForKey:@"codepostale"] intValue];
        NSString *ville = [address valueForKey:@"ville"];
        // Campus
        NSString *campusName = [st valueForKey:@"name"];
        int Id = [[st valueForKey:@"id"] intValue];
        Campus *campus = [[Campus alloc] initWithId:Id WithName:campusName withStreet:rue withPostalCode:postalCode withTown:ville withLat:lat withLng:lng];
        NSLog(@"Lat campus %@ : %f", [campus campusName] ,[campus campusLat]);
        // Add campus to list campus
        [self.listCampus addObject:campus];
    }
    
    return self.listCampus;
}

-(Campus*) getNearestCampusWithManager:(CLLocationManager*) LocationManager
{
    [self getAllCampus];
    CLLocation *curentLocation = LocationManager.location;
    // Construct Dictionary location
    NSDictionary *locations = [[NSMutableDictionary alloc] init];
    // Get distance bettewn all campus and a it to a array to get arrow location
    for(Campus *campus in self.listCampus){
        CLLocation *campusLocation = [[CLLocation alloc] initWithLatitude:[campus campusLat] longitude:[campus campusLng]];
        CLLocationDistance distance = [curentLocation distanceFromLocation:campusLocation];
        NSLog(@"Distance from Annotations - %f", distance);
        [locations setValue:campus forKey:@((distance/1000))];
    }
    
    // Sort array for get the nearest campus
    NSArray *sortedKeys = [[locations allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSArray *closestKeys = [sortedKeys subarrayWithRange:NSMakeRange(0, MIN(1, sortedKeys.count))];
    NSArray *closestAnnotations = [locations objectsForKeys:closestKeys notFoundMarker:[NSNull null]];
    
    // Return nearest campus
    Campus *campus = [closestAnnotations objectAtIndex:0];
    return campus;
}

@end
