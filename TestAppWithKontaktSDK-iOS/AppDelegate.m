//
//  AppDelegate.m
//  TestAppWithKontaktSDK-iOS
//
//  Created by Lukasz Hlebowicz on 10/22/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "AppDelegate.h"

#import "KontaktSDK.h"
#import "KTKBluetoothManager.h"

static NSString *KontaktProximityUUID = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e";

@interface AppDelegate ()
<KTKLocationManagerDelegate>

@property KTKLocationManager *locationManager;

@end


@implementation AppDelegate

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _locationManager = [KTKLocationManager new];
        _locationManager.delegate = self;
        
        return self;
    }
    
    return nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    if ([KTKLocationManager canMonitorBeacons])
    {
        KTKRegion *region =[[KTKRegion alloc] init];
        region.uuid     = KontaktProximityUUID;
        region.major    = [NSNumber numberWithLong:55555];
        region.minor    = [NSNumber numberWithLong:10114];
        
        KTKRegion *region2 =[[KTKRegion alloc] init];
        region2.uuid    = KontaktProximityUUID;
        region2.major   = [NSNumber numberWithLong:55555];
        
        [self.locationManager setRegions:@[region, region2]];
        [self.locationManager startMonitoringBeacons];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - KTKLocationManagerDelegate


- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
    }
}

- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
{
    NSLog(@"Enter region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
{
    NSLog(@"Exit region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons
{
    NSLog(@"Ranged beacons count: %lu", (unsigned long)[beacons count]);
}

@end
