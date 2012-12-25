//
//  PDLocation.h
//  LocationsMap
//
//  Created by Pradyumna Doddala on 25/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PDLocation : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) CLLocationCoordinate2D location;

- (id)initWithName:(NSString *)lName description:(NSString *)lDescription
       andLocation:(CLLocationCoordinate2D)lCoordinate;
@end
