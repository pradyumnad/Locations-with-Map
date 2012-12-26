//
//  MapPoint.h
//  LinkedInMap
//
//  Created by Pradyumna Doddala on 31/08/12.
//  Copyright (c) 2012 Pradyumna Doddala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MapPoint : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
                   title:(NSString *)aTitle
                subTitle:(NSString *)aSubTitle;


@end
