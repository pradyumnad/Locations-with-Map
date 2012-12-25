//
//  PDLocation.m
//  LocationsMap
//
//  Created by Pradyumna Doddala on 25/12/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "PDLocation.h"

@implementation PDLocation

- (id)initWithName:(NSString *)lName description:(NSString *)lDescription
       andLocation:(CLLocationCoordinate2D)lCoordinate {
    self = [super init];
    if (self) {
        _name = lName;
        _description = lDescription;
        _location = lCoordinate;
    }
    
    return self;
}
@end
