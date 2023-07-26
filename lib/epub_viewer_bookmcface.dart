
import 'epub_viewer_bookmcface_platform_interface.dart';

class EpubViewerBookmcface {
  Future<String?> getPlatformVersion() {
    return EpubViewerBookmcfacePlatform.instance.getPlatformVersion();
  }
}
