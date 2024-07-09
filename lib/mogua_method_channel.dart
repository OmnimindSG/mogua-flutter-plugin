import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mogua_platform_interface.dart';

/// An implementation of [MoguaPlatform] that uses method channels.
class MethodChannelMogua extends MoguaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mogua_method');
  final eventChannel = const EventChannel('mogua_event');

  @override
  Future<void> init({ required String appKey, bool allowClipboardAccess = true }) {
    final arguments = <String, dynamic>{
      'appKey': appKey,
      'allowClipboardAccess': allowClipboardAccess
    };
    return methodChannel.invokeMethod('init', arguments);
  }

  @override
  Future<Map<String, dynamic>> getInstallData() async {
    try {
      final map = await methodChannel.invokeMethod('getInstallData');
      return Map.from(map ?? {});
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  void getOpenData({ MoguaCallback<Map<String, dynamic>>? onData, MoguaCallback<dynamic>? onError }) {
    eventChannel.receiveBroadcastStream().listen((event) {
      onData?.call(Map<String, dynamic>.from(event));
    }).onError((error) {
      onError?.call(error);
    });
  }
}
