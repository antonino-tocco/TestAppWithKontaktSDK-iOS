//
//  ViewController.m
//  TestAppWithKontaktSDK-iOS
//
//  Created by Lukasz Hlebowicz on 10/22/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//

#import "ViewController.h"

#import "KTKBluetoothManager.h"


@interface ViewController ()
<KTKBluetoothManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelCounterBeacons;
@property (weak, nonatomic) IBOutlet UILabel *labelCounterEddystones;

@property KTKBluetoothManager *bluetoothManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    _bluetoothManager = [[KTKBluetoothManager alloc] init];
    _bluetoothManager.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
    [self.bluetoothManager startFindingDevices];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.bluetoothManager stopFindingDevices];
    
    [super viewWillDisappear:animated];
}

#pragma mark - KTKBluetoothManagerDelegate

- (void)bluetoothManager:(KTKBluetoothManager *)bluetoothManager didChangeDevices:(NSSet *)devices
{
    // here you will get ranged Kontakt's iBeacons
    NSLog(@"I found %lu Kontakt iBeacons near you", devices.count);
    
    __block ViewController *blockSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       blockSelf.labelCounterBeacons.text = [NSString stringWithFormat:@"%lu", devices.count];
                   });
}

- (void)bluetoothManager:(KTKBluetoothManager *)bluetoothManager didChangeEddystones:(NSSet *)eddystones
{
    // here you will get Eddystones
    NSLog(@"I found %lu Eddystone near you", eddystones.count);
    
    __block ViewController *blockSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       blockSelf.labelCounterEddystones.text = [NSString stringWithFormat:@"%lu", eddystones.count];
                   });
}

@end
