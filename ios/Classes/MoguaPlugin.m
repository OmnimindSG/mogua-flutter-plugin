#import "MoguaPlugin.h"
#import "MoguaSDK/MoguaSDK-Swift.h"

@implementation MoguaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:@"mogua"
                  binaryMessenger:[registrar messenger]];
    MoguaPlugin* instance = [[MoguaPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"init" isEqualToString:call.method]) {
        NSString *appKey = call.arguments[@"appKey"];
        BOOL allowClipboardAccess = call.arguments[@"allowClipboardAccess"];
        [MoguaSDK initWithAppKey: appKey allowPasteboardAccess: allowClipboardAccess];
        result(nil);
    } else if ([@"getData" isEqualToString:call.method]) {
        [MoguaSDK getDataOnData:^(NSDictionary<NSString *,id> * _Nonnull data) {
            result(data);
        } onError:^(NSError * _Nonnull error) {
        result([FlutterError errorWithCode:[@(error.code) stringValue] message:error.localizedDescription details:nil]);
    }];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
