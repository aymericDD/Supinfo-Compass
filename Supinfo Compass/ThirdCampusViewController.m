//
//  ThirdCampusViewController.m
//  Supinfo Compass
//
//  Created by Aymeric DAURELLE on 16/03/2015.
//  Copyright (c) 2015 Aymeric DAURELLE. All rights reserved.
//

#import "ThirdCampusViewController.h"

@implementation ThirdCampusViewController

static NSString *CellIdentifier = @"CampusCell";

#pragma mark - Initialization

-(void) viewDidLoad
{
    // Get campus manager
    ManagerCampus *managerCampus = [[ManagerCampus alloc] init];
    self.listCampus = [managerCampus getAllCampus];
}

#pragma mark - UITableViewDataSource Delegate

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Supinfo %@", [[self.listCampus objectAtIndex:[indexPath row]] campusName] ];
    cell.detailTextLabel.text = [[self.listCampus objectAtIndex:[indexPath row]] campusRue];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listCampus count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - UITableViewDelegate Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FourthCampusViewController *fourthVC = (FourthCampusViewController*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"FourthCampusViewController"];
    
    [fourthVC setTitle:[[self.listCampus objectAtIndex:[indexPath row]] campusName]];
    [fourthVC setCampus:[self.listCampus objectAtIndex:[indexPath row]]];
    
    [self.navigationController pushViewController:fourthVC animated:YES];
}

@end
