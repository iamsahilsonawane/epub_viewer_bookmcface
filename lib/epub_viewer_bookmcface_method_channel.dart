import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'epub_viewer_bookmcface_platform_interface.dart';

/// An implementation of [EpubViewerBookmcfacePlatform] that uses method channels.
class MethodChannelEpubViewerBookmcface extends EpubViewerBookmcfacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('epub_viewer_bookmcface');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
