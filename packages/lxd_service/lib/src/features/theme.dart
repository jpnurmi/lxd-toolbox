import 'package:lxd/lxd.dart';

import 'provider.dart';

class LxdThemeFeature extends LxdFeatureProvider {
  const LxdThemeFeature();

  @override
  Map<String, String> getConfig(LxdImage image) {
    final theme = image.properties['user.theme'];

    return {
      if (theme != null) 'user.theme': theme,
    };
  }
}
