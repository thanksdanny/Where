//
//  ViewController.m
//  Where
//
//  Created by Danny Ho on 3/1/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) CLLocationManager *locationMgr;

@property (nonatomic, strong) NSString *locality; // 城市
@property (nonatomic, strong) NSString *postalCode; // 邮编
@property (nonatomic, strong) NSString *administrativeArea; // 直辖市
@property (nonatomic, strong) NSString *country; // 国家

@end

@implementation ViewController

- (CLLocationManager *)locationMgr {
    if (!_locationMgr) {
        _locationMgr = [[CLLocationManager alloc] init];
    }
    return _locationMgr;
}

- (IBAction)myLocationButtonDidTouch {
    self.locationMgr.delegate = self;
    /*
     kCLLocationAccuracyBestForNavigation 最佳导航
     kCLLocationAccuracyBest;  最精准
     kCLLocationAccuracyNearestTenMeters;  10米
     kCLLocationAccuracyHundredMeters;  百米
     kCLLocationAccuracyKilometer;  千米
     kCLLocationAccuracyThreeKilometers;  3千米
     */
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationMgr requestAlwaysAuthorization];
    [self.locationMgr startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.locationLabel.text = [NSString stringWithFormat:@"Error while updating location %@", [error localizedDescription]];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [[[CLGeocoder alloc] init] reverseGeocodeLocation:manager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error != nil) {
            self.locationLabel.text = [NSString stringWithFormat:@"Reverse geocoder failed with error %@", error.localizedDescription];
            return ;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *pm = placemarks[0];
            [self displayLocationInfo:pm];
        } else {
            self.locationLabel.text = @"Problem with the data received from geocoder";
        }
    }];
}

- (void)displayLocationInfo:(CLPlacemark *)placemark {
    if (placemark) {
        [self.locationMgr stopUpdatingLocation];
        if (placemark.locality) {
            self.locality = [NSString stringWithFormat:@"%@", placemark.locality];
        }
        if (placemark.postalCode) {
            self.postalCode = [NSString stringWithFormat:@"%@", placemark.postalCode];
        }
        if (placemark.administrativeArea) {
            self.administrativeArea = [NSString stringWithFormat:@"%@", placemark.administrativeArea];
        }
        if (placemark.country) {
            self.country = [NSString stringWithFormat:@"%@", placemark.country];
        }
        self.locationLabel.text = [NSString stringWithFormat:@"%@%@%@", self.locality, self.administrativeArea, self.country];
    }
}


// 记得写去掉状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
