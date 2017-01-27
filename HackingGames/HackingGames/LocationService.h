//
//  LocationService.h
//
//  Created by Mohamed Arradi-Alaoui on 03/09/2016.
//  Copyright © 2016 Mohamed Arradi-Alaoui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationService : NSObject <CLLocationManagerDelegate>


+(LocationService *) sharedInstance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

- (void)startUpdatingLocation;

@end
