#import "MoguaPlugin.h"
#import "MoguaSDK/MoguaSDK-Swift.h"

@implementation MoguaPlugin

BOOL _isSdkInitialized = false;
BOOL _isEventsReady = false;
NSURL * _pendingURL;
NSUserActivity * _pendingUserActivity;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"mogua_method" binaryMessenger:[registrar messenger]];
    FlutterEventChannel* eventChannel = [FlutterEventChannel eventChannelWithName:@"mogua_event" binaryMessenger:[registrar messenger]];
    MoguaPlugin* instance = [[MoguaPlugin alloc] init];
    [registrar addApplicationDelegate:instance];
    [registrar addMethodCallDelegate:instance channel:channel];
    [eventChannel setStreamHandler:instance];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self handleOpenAppFromURLWrapper:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenAppFromURLWrapper:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [self handleOpenAppFromURLWrapper:url];
}

- (BOOL)handleOpenAppFromURLWrapper:(NSURL *)url {
    if (![self handleOpenAppFromURL:url]) {
        _pendingURL = url;
        return false;
    }
    return true;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nonnull))restorationHandler {
    if (![self handleOpenAppFromUserActivity: userActivity]) {
        _pendingUserActivity = userActivity;
        return false;
    }
    return true;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"init" isEqualToString:call.method]) {
        NSString *appKey = call.arguments[@"appKey"];
        BOOL allowClipboardAccess = call.arguments[@"allowClipboardAccess"];
        [Mogua initWithAppKey: appKey allowPasteboardAccess: allowClipboardAccess];
        _isSdkInitialized = true;
        [self handlePendings];
        result(nil);
    } else if ([@"getInstallData" isEqualToString:call.method]) {
        [Mogua getInstallDataOnData:^(NSDictionary<NSString *,id> * _Nonnull data) {
            result(data);
        } onError:^(NSError * _Nonnull error) {
            result([FlutterError errorWithCode:[@(error.code) stringValue] message:error.localizedDescription details:nil]);
        }];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (BOOL)handleOpenAppFromURL:(NSURL *)url {
    if (!_isSdkInitialized || !_isEventsReady) {
        return false;
    }
    (void)[Mogua handleOpenUrl:url];
    return true;
}

- (BOOL)handleOpenAppFromUserActivity: (NSUserActivity *)userActivity {
    if (!_isSdkInitialized || !_isEventsReady) {
        return false;
    }
    (void)[Mogua handleUserActivity:userActivity];
    return true;
}

- (void)handlePendings {
    if (_pendingURL != nil && [self handleOpenAppFromURL:_pendingURL]) {
        _pendingURL = nil;
    }
    if (_pendingUserActivity != nil && [self handleOpenAppFromUserActivity:_pendingUserActivity]) {
        _pendingUserActivity = nil;
    }
}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    [Mogua getOpenDataOnData:^(NSDictionary<NSString *,id> * _Nonnull data) {
        events(data);
    } onError:^(NSError * _Nonnull error) {
        events([FlutterError errorWithCode:[@(error.code) stringValue] message:error.localizedDescription details:nil]);
    }];
    _isEventsReady = true;
    [self handlePendings];
    return nil;
}

- (FlutterError *)onCancelWithArguments:(id)arguments {
    _isEventsReady = false;
    return nil;
}

@end
