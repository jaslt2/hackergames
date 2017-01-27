//
//  LocationService.m
//
//  Created by Mohamed Arradi-Alaoui on 03/09/2016.
//  Copyright © 2016 Mohamed Arradi-Alaoui. All rights reserved.
//

#import "LocationService.h"

@implementation LocationService


+(LocationService *) sharedInstance
{
    static LocationService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 100; // meters
        self.locationManager.delegate = self;
        [self startUpdatingLocation];
    }
    return self;
}

- (void)startUpdatingLocation
{
    //  NSLog(@"Starting location updates");
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
     NSLog(@"Location service failed with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations
{
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
}

- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}


- (void)locationError:(NSError *)error
{
    [self stopUpdatingLocation];
    
    switch([error code])
    {
        case kCLErrorDenied:
            break;
        case kCLErrorLocationUnknown:
            break;
        default:
            break;
    }
}

-(void)locationChangeStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            [self.locationManager startUpdatingLocation];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh_map_location" object:NULL];
            break;
        case kCLAuthorizationStatusDenied:
        default:
            break;
    }
}

@end
