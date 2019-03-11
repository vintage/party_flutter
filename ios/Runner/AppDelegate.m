#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* rotationChannel = [FlutterMethodChannel
                                             methodChannelWithName:@"zgadula/orientation"
                                             binaryMessenger:controller];
    
    [rotationChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"setLandscape" isEqualToString:call.method]) {
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        }
        else if ([@"setPortrait" isEqualToString:call.method]) {
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        }
        else {
            result(FlutterMethodNotImplemented);
        }
    }];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
