import 'package:flutter_test/flutter_test.dart';
import 'package:epub_viewer_bookmcface/epub_viewer_bookmcface.dart';
import 'package:epub_viewer_bookmcface/epub_viewer_bookmcface_platform_interface.dart';
import 'package:epub_viewer_bookmcface/epub_viewer_bookmcface_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEpubViewerBookmcfacePlatform
    with MockPlatformInterfaceMixin
    implements EpubViewerBookmcfacePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> openViewer(String epubPath) {
    return Future.value(null);
  }
}

void main() {
  final EpubViewerBookmcfacePlatform initialPlatform =
      EpubViewerBookmcfacePlatform.instance;

  test('$MethodChannelEpubViewerBookmcface is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEpubViewerBookmcface>());
  });

  test('getPlatformVersion', () async {
    EpubViewerBookmcface epubViewerBookmcfacePlugin = EpubViewerBookmcface();
    MockEpubViewerBookmcfacePlatform fakePlatform =
        MockEpubViewerBookmcfacePlatform();
    EpubViewerBookmcfacePlatform.instance = fakePlatform;

    expect(await epubViewerBookmcfacePlugin.getPlatformVersion(), '42');
  });
}
