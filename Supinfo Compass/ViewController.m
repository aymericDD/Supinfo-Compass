//
//  ViewController.m
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 08/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize listCampus, arrowImageView;

GeoPointCompass *geoPointCompass;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create the image for the compass
    UIImageView  *ImageViewCompass = [[UIImageView alloc] init];
    ImageViewCompass.image = [UIImage imageNamed:@"arrow.png"];
    [ImageViewCompass sizeToFit];
    [self.view addSubview:ImageViewCompass];
    ImageViewCompass.center = self.view.center;
    self.arrowImageView = ImageViewCompass;
    
    // Get manager campus
    self.managerCampus = [[ManagerCampus alloc] init];
    
    geoPointCompass = [[GeoPointCompass alloc] init];

}

-(void)viewDidAppear:(BOOL)animated
{
    [self chargeCompass];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)chargeCompass
{
    
    geoPointCompass.manageCampus = self.managerCampus;
    
    geoPointCompass.targetCampus = [self.managerCampus getNearestCampusWithManager:self.locationManager];
    
    // Add the image to be used as the compass on the GUI
    [geoPointCompass setArrowImageView:self.arrowImageView];
    
    [geoPointCompass setNameCampusLabel:self.CampusNameLabel];
    
    [geoPointCompass setDistanceCampusLabel:self.DistanceCampusLabel];
    
}

@end
