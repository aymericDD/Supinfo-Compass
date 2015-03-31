//
//  Campus.h
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 08/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Campus : NSObject

@property( nonatomic, assign ) int Id;
@property( nonatomic, strong ) NSString *campusName;
@property( nonatomic, strong ) NSString *campusRue;
@property( nonatomic, assign ) int campusCodePostale;
@property( nonatomic, strong ) NSString *campusVille;
@property( nonatomic, assign ) float campusLat;
@property( nonatomic, assign ) float campusLng;

-(id) initWithId:(int)pId WithName:(NSString*)pName withStreet:(NSString*) pStreet withPostalCode:(int)pPostalCode withTown:(NSString*)pTown withLat:(float)pLat withLng:(float)pLong;

@end
