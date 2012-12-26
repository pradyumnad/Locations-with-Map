//
//  ViewController.m
//  LocationsMap
//
//  Created by Pradyumna Doddala on 25/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "ViewController.h"
#import "PDLocationsMapViewController.h"
#import "PDLocation.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLocations:(id)sender {
    PDLocationsMapViewController *locationsMapViewController = [[PDLocationsMapViewController alloc] initWithDelegate:self andDataSource:self];
    [self presentModalViewController:locationsMapViewController animated:YES];
    
//    UIApplication *application = [NSApplication sharedApplication];
//    NSWindow *keyWindow = [application keyWindow];
//    [keyWindow miniaturize:keyWindow];
}

#pragma mark -
#pragma mark PDLocationsMapView

- (NSArray *)locationsForShowingInLocationsMap {
    PDLocation *loc1 = [[PDLocation alloc] initWithName:@"Test 1" description:@"Nothing but a G thang" andLocation:CLLocationCoordinate2DMake(17.85f, 85.56f)];
    PDLocation *loc2 = [[PDLocation alloc] initWithName:@"Test 2" description:@"Nothing but a G thang" andLocation:CLLocationCoordinate2DMake(35.51, 77.814)];
    PDLocation *loc3 = [[PDLocation alloc] initWithName:@"Test 3" description:@"Nothing but a G thang" andLocation:CLLocationCoordinate2DMake(6.74, 93.84)];

    return [NSArray arrayWithObjects:loc1, loc2, loc3, nil];
}

- (void)didSelectLocationAtIndex:(int)index {
    
}
@end
