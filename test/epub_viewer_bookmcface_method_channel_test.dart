import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epub_viewer_bookmcface/epub_viewer_bookmcface_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelEpubViewerBookmcface platform = MethodChannelEpubViewerBookmcface();
  const MethodChannel channel = MethodChannel('epub_viewer_bookmcface');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
