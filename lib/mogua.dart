import 'mogua_platform_interface.dart';

class Mogua {
  static Future<void> init(
          {required String appKey, bool allowClipboardAccess = true}) =>
      MoguaPlatform.instance
          .init(appKey: appKey, allowClipboardAccess: allowClipboardAccess);

  static Future<Map<String, dynamic>> getData() =>
      MoguaPlatform.instance.getData();
}
