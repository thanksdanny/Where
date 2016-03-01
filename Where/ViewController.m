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
    
}




// 记得写去掉状态栏
- (void)qudiaozhuangtailan {
    
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
