import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'epub_viewer_bookmcface_method_channel.dart';

abstract class EpubViewerBookmcfacePlatform extends PlatformInterface {
  /// Constructs a EpubViewerBookmcfacePlatform.
  EpubViewerBookmcfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static EpubViewerBookmcfacePlatform _instance = MethodChannelEpubViewerBookmcface();

  /// The default instance of [EpubViewerBookmcfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelEpubViewerBookmcface].
  static EpubViewerBookmcfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EpubViewerBookmcfacePlatform] when
  /// they register themselves.
  static set instance(EpubViewerBookmcfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
