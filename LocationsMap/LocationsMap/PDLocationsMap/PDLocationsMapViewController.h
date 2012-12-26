//
//  PDLocationsMapViewController.h
//  LocationsMap
//
//  Created by Pradyumna Doddala on 25/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol PDLocationsMapDelegate <NSObject>

- (void)didSelectLocationAtIndex:(int)index;
@end

@protocol PDLocationsMapDataSource <NSObject>

- (NSArray *)locationsForShowingInLocationsMap;
@end

@interface PDLocationsMapViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate> {
    __unsafe_unretained id <PDLocationsMapDataSource>dataSource;
    __unsafe_unretained id <PDLocationsMapDelegate>delegate;
}

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;

@property (nonatomic, assign) __unsafe_unretained id <PDLocationsMapDataSource>dataSource;
@property (nonatomic, assign) __unsafe_unretained id <PDLocationsMapDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (id)initWithDelegate:(id)delegate andDataSource:(id)dataSource;
@end
