import 'mogua_platform_interface.dart';

class Mogua {
  /// Initialize Mogua.
  /// [appKey] The App Key associated with this application, available on the dashboard at www.mogua.io.
  /// [allowClipboardAccess] A Boolean value indicating whether to allow access to the clipboard.
  /// Enabling this feature can enhance accuracy but may trigger permission warnings on certain systems.
  static Future<void> init({ required String appKey, bool allowClipboardAccess = true }) =>
      MoguaPlatform.instance.init(appKey: appKey, allowClipboardAccess: allowClipboardAccess);

  /// Retrieve the data carried during the app installation.
  /// Relevant statistics can be viewed on the dashboard at www.mogua.io.
  /// Return the data (key-value pairs) or any exceptions that occur.
  /// The data is cached, ensuring identical return values for subsequent calls to [getInstallData].
  static Future<Map<String, dynamic>> getInstallData() => MoguaPlatform.instance.getInstallData();

  /// Registers callbacks to handle data when the app is activated via a URL
  /// (e.g., clicking a link, scanning a QR code).
  /// [onData] The callback to handle the retrieved data (key-value pairs)
  /// [onError] The callback to handle any exceptions that occur.
  static void getOpenData({ MoguaCallback<Map<String, dynamic>>? onData, MoguaCallback<dynamic>? onError }) =>
      MoguaPlatform.instance.getOpenData(onData: onData, onError: onError);
}
