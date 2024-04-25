import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mogua_platform_interface.dart';

/// An implementation of [MoguaPlatform] that uses method channels.
class MethodChannelMogua extends MoguaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mogua');

  @override
  Future<void> init({ required String appKey, bool allowClipboardAccess = true }) {
    final arguments = <String, dynamic>{ 'appKey': appKey, 'allowClipboardAccess': allowClipboardAccess };
    return methodChannel.invokeMethod('init', arguments);
  }

  @override
  Future<Map<String, dynamic>> getData() async {
    try {
      final map = await methodChannel.invokeMethod('getData');
      return Map.from(map ?? {});
    } catch (error) {
      return Future.error(error);
    }
  }
}
