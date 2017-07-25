//
//  ThirdCampusViewController.h
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 16/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ManagerCampus.h"
#import "FourthCampusViewController.h"

@interface ThirdCampusViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property( nonatomic, strong ) NSMutableArray *listCampus;

@end
