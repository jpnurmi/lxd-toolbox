import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'settings_store.dart';

class HiveSettingsStore with ChangeNotifier implements SettingsStore {
  HiveSettingsStore(this._name);
  HiveSettingsStore.of(this._hive) : _name = '';

  final String _name;
  Box? _hive;
  StreamSubscription? _sub;

  @override
  Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);

    _hive ??= await Hive.openBox(_name);
    _sub ??= _hive!.watch().listen((_) => notifyListeners());

    print('##################################');
    print(_hive?.path);
    print('##################################');
  }

  @override
  Iterable<String> get keys => _hive?.keys.cast<String>() ?? [];

  @override
  T? get<T>(String key) => _hive!.get(key) as T?;

  @override
  Future<void> set<T>(String key, T value) => _hive!.put(key, value);

  @override
  Future<void> unset(String key) => _hive!.delete(key);

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    await _hive?.close();
    super.dispose();
  }
}
