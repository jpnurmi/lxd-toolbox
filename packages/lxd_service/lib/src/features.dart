import 'package:lxd/lxd.dart';

import 'features/audio.dart';
import 'features/graphics.dart';
import 'features/home.dart';
import 'features/provider.dart';
import 'features/server.dart';
import 'features/theme.dart';
import 'features/user.dart';

export 'features/provider.dart';

enum LxdFeature {
  user(const LxdUserFeature()),
  home(const LxdHomeFeature()),
  graphics(const LxdGraphicsFeature()),
  audio(const LxdAudioFeature()),
  theme(const LxdThemeFeature()),
  lxd(const LxdServerFeature());

  const LxdFeature(this._provider);
  final LxdFeatureProvider _provider;

  bool isSupported(LxdImageType type) =>
      _provider.supportedTypes.contains(type);

  static LxdFeatureProvider get(LxdFeature feature) => feature._provider;
}
