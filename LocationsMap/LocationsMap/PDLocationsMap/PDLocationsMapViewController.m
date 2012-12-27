//
//  PDLocationsMapViewController.m
//  LocationsMap
//
//  Created by Pradyumna Doddala on 25/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "PDLocationsMapViewController.h"
#import "PDLocation.h"
#import "MapPoint.h"

static CGRect MapOriginalFrame;
static CGRect MapFullFrame;
static CGPoint MapCenter;

@interface PDLocationsMapViewController ()

@property (nonatomic, strong) NSArray *locations;

- (void)showAnnotationsOnMapWithLocations:(NSArray *)aLocations;
- (MKCoordinateRegion)regionThatFitsAllLocations:(NSArray *)locations;

- (IBAction)tappedOnMapView;
@end

@implementation PDLocationsMapViewController

@synthesize delegate = _delegate, dataSource = _dataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDelegate:(id)delegate andDataSource:(id)dataSource {
    self = [super initWithNibName:@"PDLocationsMapViewController" bundle:nil];
    if (self) {
        // Custom initialization
        _delegate = delegate;
        _dataSource = dataSource;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MapCenter = self.mapView.center;
    MapOriginalFrame = self.mapView.frame;
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    MapFullFrame = CGRectMake(0, 0, size.width, size.height);
    
    self.closeButton.hidden = YES;
    
    [self.tapGesture addTarget:self action:@selector(tappedOnMapView)];
    [self.mapView addGestureRecognizer:self.tapGesture];
    
    NSLog(@"%@ %@", [NSValue valueWithCGRect:MapOriginalFrame], [NSValue valueWithCGRect:MapFullFrame]);
    
    //User location tracking
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager startUpdatingLocation];
    
    _userLocation = [_locationManager.location copy];
    
    NSLog(@"%f %f User location", self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude);
    //DataSource
    if ([self.dataSource respondsToSelector:@selector(locationsForShowingInLocationsMap)]) {
        _locations = [self.dataSource locationsForShowingInLocationsMap];

        [self showAnnotationsOnMapWithLocations:self.locations];
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
#pragma mark Helpers

- (void)showAnnotationsOnMapWithLocations:(NSArray *)aLocations {
    for (PDLocation *location in aLocations) {
        MapPoint *mapPoint = [[MapPoint alloc] initWithCoordinate:location.location title:location.name subTitle:location.description];
        [self.mapView addAnnotation:mapPoint];
    }
    
    MKCoordinateRegion region = [self regionThatFitsAllLocations:self.locations];
    [self.mapView setRegion:region];
}

- (MKCoordinateRegion)regionThatFitsAllLocations:(NSArray *)locations {
    float Lat_Min = self.userLocation.coordinate.latitude, Lat_Max = self.userLocation.coordinate.latitude;
    float Long_Max = self.userLocation.coordinate.longitude, Long_Min = self.userLocation.coordinate.longitude;
    
    for (PDLocation *p in self.locations) {
        if (Lat_Max > p.location.latitude) {
            Lat_Min = p.location.latitude;
        } else {
            Lat_Max = p.location.latitude;
        }
        
        if (Long_Max > p.location.longitude) {
            Long_Min = p.location.longitude;
        } else {
            Long_Max = p.location.longitude;
        }
        
        NSLog(@"%f %f", p.location.latitude, p.location.longitude);
    }
    NSLog(@">>> %f %f %f %f", Lat_Min, Lat_Max, Long_Min, Long_Max);
    
    CLLocationCoordinate2D min = CLLocationCoordinate2DMake(Lat_Min, Long_Min);
    
    CLLocationCoordinate2D max = CLLocationCoordinate2DMake(Lat_Max, Long_Max);
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((max.latitude + min.latitude) / 2.0, (max.longitude + min.longitude) / 2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(max.latitude - min.latitude, max.longitude - min.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    return region;
}

- (IBAction)tappedOnMapView {
    NSLog(@"Tapped");
    [self.view bringSubviewToFront:self.mapView];
    
    if (CGRectEqualToRect(self.mapView.bounds, MapOriginalFrame)) {
        [UIView animateWithDuration:0.30 animations:^{
            self.mapView.frame = MapFullFrame;
        } completion:^(BOOL finished) {
            self.closeButton.hidden = NO;
            [self.view bringSubviewToFront:self.closeButton];
            [self.mapView removeGestureRecognizer:self.tapGesture];
            NSLog(@"After done %@", [NSValue valueWithCGRect:self.mapView.bounds]);
        }];
    } else {
        [UIView animateWithDuration:0.30 animations:^{
            self.mapView.frame = MapOriginalFrame;
        } completion:^(BOOL finished) {
            self.closeButton.hidden = YES;
            [self.mapView addGestureRecognizer:self.tapGesture];
            NSLog(@"After done %@", [NSValue valueWithCGRect:self.mapView.bounds]);
        }];
    }
}

#pragma mark -
#pragma mark CoreLocation
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
    _userLocation = newLocation;
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark MapView

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id < MKAnnotation >)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
     
    static NSString* PDAnnotationIdentifier = @"PDAnnotationIdentifier";
    
    MKAnnotationView* pinView =
    (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:PDAnnotationIdentifier];
    if (!pinView) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:PDAnnotationIdentifier];
        [pinView setImage:[UIImage imageNamed:@"mappin.png"]];
        pinView.canShowCallout = YES;
    }
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
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
        
        cell.textLabel.font = [UIFont fontWithName:@"Futura" size:15.0f];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Futura" size:13.0f];
        
        UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0, 25.0)];
        distanceLabel.font = [UIFont fontWithName:@"Futura" size:12.0f];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textColor = [UIColor grayColor];
        distanceLabel.textAlignment = UITextAlignmentRight;
        cell.accessoryView = distanceLabel;
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
    cell.detailTextLabel.text = pdLocation.description;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:pdLocation.location.latitude longitude:pdLocation.location.longitude];
    
    CLLocationDistance distance = [_userLocation distanceFromLocation:location];
    if (distance == 0) {
        
    } else {
        UILabel *distanceLabel = (UILabel *)cell.accessoryView;
        distanceLabel.text = [NSString stringWithFormat:@"%.01f Km", distance/1000];
    }
}

- (void)viewDidUnload {
    [self setTapGesture:nil];
    [self setCloseButton:nil];
    [super viewDidUnload];
}
@end
