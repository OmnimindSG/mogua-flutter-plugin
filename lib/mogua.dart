
import 'mogua_platform_interface.dart';

class Mogua {
  Future<String?> getPlatformVersion() {
    return MoguaPlatform.instance.getPlatformVersion();
  }
}
