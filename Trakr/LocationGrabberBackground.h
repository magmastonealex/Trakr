//
//  LocationGrabberBackground.h
//  D2DPro
//
//  Created by Anne Roth on 13-08-09.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "TkMainViewController.h"

@interface LocationGrabberBackground : NSObject <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString * devid;
@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) TkMainViewController * del;
-(void)locationFrequency:(int)freqMin;
-(id)init:(TkMainViewController*)delegate;
@end
