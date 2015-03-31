//
//  Campus.m
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 08/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import "Campus.h"

@implementation Campus

@synthesize Id, campusCodePostale, campusLat, campusLng, campusName, campusRue, campusVille;

-(id) initWithId:(int)pId WithName:(NSString *)pName withStreet:(NSString *)pStreet withPostalCode:(int)pPostalCode withTown:(NSString *)pTown withLat:(float)pLat withLng:(float)pLong
{
    self.Id = pId;
    self.campusName = pName;
    self.campusRue = pStreet;
    self.campusCodePostale = pPostalCode;
    self.campusVille = pTown;
    self.campusLat = pLat;
    self.campusLng = pLong;
    return self;
}

@end
