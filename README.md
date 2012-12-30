Locations-with-Map
==================

This is similar to Foursquare style of showing Location list with Mapview.

PDLocationsMapViewController is used to provide an interface as shown in the delow screen shot. 
<img src="https://github.com/pradyumnad/Locations-with-Map/Screen 1.">
<img src="">

Including into Project
-----------------------


	#import "PDLocationsMap.h"


	PDLocationsMapViewController *locationsMapViewController = [[PDLocationsMapViewController alloc] initWithDelegate:self andDataSource:self];
    [self presentModalViewController:locationsMapViewController animated:YES];



> PDLocationsMapDataSource

Return array of PDlocations to be shown on the map.

	- (NSArray *)locationsForShowingInLocationsMap {
    PDLocation *loc1 = [[PDLocation alloc] initWithName:@"" description:@"" andLocation:CLLocationCoordinate2DMake];
    

    return [NSArray arrayWithObjects:loc1, nil];
}

> PDLocationsMapDelegate

Returns the index of location selected.

	- (void)didSelectLocationAtIndex:(int)index {
	
   	}