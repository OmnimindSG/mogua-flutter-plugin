import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mogua_platform_interface.dart';

/// An implementation of [MoguaPlatform] that uses method channels.
class MethodChannelMogua extends MoguaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mogua');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
