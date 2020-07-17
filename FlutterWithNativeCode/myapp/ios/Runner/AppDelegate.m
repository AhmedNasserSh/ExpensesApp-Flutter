#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  FlutterViewController* controller = (FlutterViewController*) self.window.rootViewController;
    
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"myapp/batteryLevel" binaryMessenger:controller];
    
    __weak typeof(self) weakSelf = self;

    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([@"getBatteryLevel" isEqualToString:call.method]) {
            int level = 90 ; //[weakSelf getBattteryLevel];
            if(level == -1) {
                result([FlutterError errorWithCode:@"Battery Level UnAvailable" message:@"Battery Level UnAvailable" details:nil]);
            }else{
                result(@(level));
            }
        }else {
            result(FlutterMethodNotImplemented);
        }
    }];
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

-(int) getBattteryLevel {
    UIDevice* device = UIDevice.currentDevice;
    device.batteryMonitoringEnabled = YES;
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return -1;
    }
    return (int)(device.batteryLevel * 100 );
}

@end
