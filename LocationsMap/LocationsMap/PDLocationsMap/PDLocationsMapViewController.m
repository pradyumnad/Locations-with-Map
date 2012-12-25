//
//  PDLocationsMapViewController.m
//  LocationsMap
//
//  Created by Pradyumna Doddala on 25/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "PDLocationsMapViewController.h"
#import "PDLocation.h"

@interface PDLocationsMapViewController ()

@property (nonatomic, strong) NSArray *locations;
@end

@implementation PDLocationsMapViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //User location tracking
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager startUpdatingLocation];
    
    _userLocation = [_locationManager.location copy];
    
    //DataSource
    if ([self.dataSource respondsToSelector:@selector(locationsForShowingInLocationsMap)]) {
        _locations = [self.dataSource locationsForShowingInLocationsMap];
    } else {
        NSLog(@"PDLocationsMapViewDataSource not set");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CoreLocation
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    _userLocation = [newLocation copy];
    [self.tableView reloadData];
}



#pragma mark - TableView Methods
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.locations count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:18.0f];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Futura" size:13.0f];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    id store = [self.locations objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectLocationAtIndex:)]) {
        [self.delegate didSelectLocationAtIndex:indexPath.row];
    } else {
        NSLog(@"PDLocationsMapViewDelegate not set");
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    PDLocation *pdLocation = [self.locations objectAtIndex:indexPath.row];
    NSAssert([pdLocation isKindOfClass:[PDLocation class]], @"DataSource must provide array of PDLocations");
    
    cell.textLabel.text = pdLocation.name;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:pdLocation.location.latitude longitude:pdLocation.location.longitude];
    
    CLLocationDistance distance = [_userLocation distanceFromLocation:location];
    if (distance == 0) {
        
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.01f Km", distance/1000];
    }
}

@end
