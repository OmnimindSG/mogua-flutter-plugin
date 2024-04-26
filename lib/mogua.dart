import 'mogua_platform_interface.dart';

class Mogua {
  /// Initialize Mogua.
  /// [appKey] The App Key associated with your application, you can find it on the mogua.io dashboard.
  /// [allowClipboardAccess] Whether to allow access to the clipboard.
  /// Enabling [allowClipboardAccess] can enhance accuracy, but may trigger permission warnings.
  static Future<void> init(
          {required String appKey, bool allowClipboardAccess = true}) =>
      MoguaPlatform.instance
          .init(appKey: appKey, allowClipboardAccess: allowClipboardAccess);

  /// Retrieves data from the Mogua platform.
  /// Returns the data asynchronously, containing the parameters received from the web.
  /// This data is cached, ensuring identical return values for subsequent calls to [getData].
  static Future<Map<String, dynamic>> getData() =>
      MoguaPlatform.instance.getData();
}
