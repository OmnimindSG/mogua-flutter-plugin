import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mogua_method_channel.dart';

abstract class MoguaPlatform extends PlatformInterface {
  /// Constructs a MoguaPlatform.
  MoguaPlatform() : super(token: _token);

  static final Object _token = Object();

  static MoguaPlatform _instance = MethodChannelMogua();

  /// The default instance of [MoguaPlatform] to use.
  ///
  /// Defaults to [MethodChannelMogua].
  static MoguaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MoguaPlatform] when
  /// they register themselves.
  static set instance(MoguaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init({ required String appKey, required bool allowClipboardAccess }) {
    throw UnimplementedError('Method init has not been implemented.');
  }

  Future<Map<String, dynamic>> getData() {
    throw UnimplementedError('Method getData has not been implemented.');
  }
}
