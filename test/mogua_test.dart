import 'package:flutter_test/flutter_test.dart';
import 'package:mogua/mogua.dart';
import 'package:mogua/mogua_platform_interface.dart';
import 'package:mogua/mogua_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMoguaPlatform
    with MockPlatformInterfaceMixin
    implements MoguaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MoguaPlatform initialPlatform = MoguaPlatform.instance;

  test('$MethodChannelMogua is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMogua>());
  });

  test('getPlatformVersion', () async {
    Mogua moguaPlugin = Mogua();
    MockMoguaPlatform fakePlatform = MockMoguaPlatform();
    MoguaPlatform.instance = fakePlatform;

    expect(await moguaPlugin.getPlatformVersion(), '42');
  });
}
