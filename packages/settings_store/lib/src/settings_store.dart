import 'dart:io';

import 'package:flutter/foundation.dart';

import 'gsettings_store.dart';
import 'hive_settings_store.dart';

abstract class SettingsStore with ChangeNotifier {
  factory SettingsStore(
    String schemaId, {
    @visibleForTesting Map<String, String>? env,
  }) {
    env ??= Platform.environment;
    if (env['SETTINGS_STORE'] == 'hive') {
      return HiveSettingsStore(schemaId);
    } else {
      return GSettingsStore(schemaId);
    }
  }

  Future<void> init();

  Iterable<String> get keys;
  T? get<T>(String key);
  Future<void> set<T>(String key, T value);
  Future<void> unset(String key);
}
