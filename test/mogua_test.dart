import 'package:flutter_test/flutter_test.dart';
import 'package:mogua/mogua.dart';
import 'package:mogua/mogua_platform_interface.dart';
import 'package:mogua/mogua_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMoguaPlatform
    with MockPlatformInterfaceMixin
    implements MoguaPlatform {

  @override
  Future<void> init({required String appKey, required bool allowClipboardAccess}) async {
    return;
  }

  @override
  Future<Map<String, dynamic>> getData() async {
    return {};
  }

}

void main() {
  final MoguaPlatform initialPlatform = MoguaPlatform.instance;

  test('$MethodChannelMogua is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMogua>());
  });

  // Check this: https://docs.flutter.dev/testing/plugins-in-tests

  test('getData', () async {
    MockMoguaPlatform fakePlatform = MockMoguaPlatform();
    MoguaPlatform.instance = fakePlatform;

    expect(await Mogua.getData(), isInstanceOf<Map>());
  });
}
