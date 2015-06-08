//
//  LocationGrabberBackground.m
//  D2DPro
//
//  Created by Anne Roth on 13-08-09.
//
//

#import "LocationGrabberBackground.h"


@implementation LocationGrabberBackground
@synthesize locationManager;
@synthesize devid;
@synthesize userID;
@synthesize del;
int freqMinutes;
long triggerTime;
-(id)init:(TkMainViewController*)delegate{
    self = [super init];
    if(self){
        del = delegate;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        self.locationManager.delegate = self;

    }
    //NSLog(@"Ready to start updating location.");
    
    return self;
}

-(void)locationFrequency:(int)freqMin{
    if(freqMin == 10000){
        [self.locationManager stopUpdatingLocation];
        NSLog(@"Stopped updating location.");
    }
    else{
    triggerTime = CFAbsoluteTimeGetCurrent()+5;
    freqMinutes=freqMin;
    [self.locationManager startUpdatingLocation];
    
    }
}
- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    NSLog(encodedDictionary);
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loc = [locations objectAtIndex:0];
    if(CFAbsoluteTimeGetCurrent() > triggerTime){
        triggerTime = CFAbsoluteTimeGetCurrent()+5;
        NSLog(@"Updating location : %f, %f", loc.coordinate.latitude, loc.coordinate.longitude);
        NSDate *date         = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"hh-mm-ss"];
        [del updateLastLabel:[df stringFromDate:date]];
        NSURL *url = [NSURL URLWithString:@"http://trakr.magmastone.net/location"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:3.0];
            
            
       
            NSMutableDictionary * mutPostDict = [[NSMutableDictionary alloc] initWithCapacity:10];
            [mutPostDict setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"uuid"];
            [mutPostDict setValue:[NSString stringWithFormat:@"%f", loc.coordinate.latitude] forKey:@"latitude"];
            [mutPostDict setValue:[NSString stringWithFormat:@"%f", loc.coordinate.longitude] forKey:@"longitude"];
             [request setAllHTTPHeaderFields:mutPostDict];
            NSData * postData = [self encodeDictionary:mutPostDict];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        //NSLog(@"%@", postData);
            [request setHTTPBody:postData];
            
           // NSLog(@"Will post request. %@", [request description]);
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection start];
        
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
}


@end
