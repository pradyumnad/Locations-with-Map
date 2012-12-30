//
//  ViewController.m
//  LocationsMap
//
//  Created by Pradyumna Doddala on 25/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "ViewController.h"
#import "PDLocationsMap.h"
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
}

#pragma mark -
#pragma mark PDLocationsMapView

- (NSArray *)locationsForShowingInLocationsMap {
    PDLocation *loc1 = [[PDLocation alloc] initWithName:@"Agra" description:@"A city on the Jumna River in Uttar Pradesh state, northern India; pop. 899,000. Once the capital of the Mogul empire 1566–1658, it is the site of the Taj Mahal" andLocation:CLLocationCoordinate2DMake(27.177023,78.007862)];
    PDLocation *loc2 = [[PDLocation alloc] initWithName:@"Kanyakumari" description:@"Kanyakumari is a town in Kanyakumari district in Tamil Nadu state, India. Located at the southernmost tip of the Indian Peninsula, its former name was Cape Comorin" andLocation:CLLocationCoordinate2DMake(8.092881,77.538388)];
    PDLocation *loc3 = [[PDLocation alloc] initWithName:@"Mysore" description:@"Mysore is a tourism hot spot within the state of Karnataka and also acts as a base for other tourist places in the vicinity of the city." andLocation:CLLocationCoordinate2DMake(12.303442,76.64023)];

    return [NSArray arrayWithObjects:loc1, loc2, loc3, nil];
}

- (void)didSelectLocationAtIndex:(int)index {
    
}
@end
