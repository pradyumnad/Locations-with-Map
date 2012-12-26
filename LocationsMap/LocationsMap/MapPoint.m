//
//  MapPoint.m
//  LinkedInMap
//
//  Created by Pradyumna Doddala on 31/08/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

@synthesize title, subTitle, coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
                   title:(NSString *)aTitle
                subTitle:(NSString *)aSubTitle {
    self = [super init];
    if (self) {
        coordinate = aCoordinate;
        title = aTitle;
        subTitle = aSubTitle;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = coordinate.latitude;
    theCoordinate.longitude = coordinate.longitude;
    return theCoordinate;
}

- (NSString *)title {
    return title;
}

// optional
- (NSString *)subtitle {
    return subTitle;
}

@end
