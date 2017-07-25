//
//  Request.h
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 16/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

-(NSArray*) getDataByUrl:(NSString*) p_url;

@end
