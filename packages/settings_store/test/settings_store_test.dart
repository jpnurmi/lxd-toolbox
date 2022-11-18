import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gio_settings/gio_settings.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:settings_store/settings_store.dart';

import 'settings_store_test.mocks.dart';

@GenerateMocks([GioSettings])
void main() {
  MockGioSettings mockGioSettings({
    Map<String, dynamic> values = const {},
    Stream<List<String>> keysChanged = const Stream.empty(),
  }) {
    final mock = MockGioSettings();
    when(mock.list()).thenAnswer((_) => Future.value(values.keys.toList()));
    when(mock.get(any)).thenAnswer((_) {
      final key = _.positionalArguments[0] as String;
      return Future.value(values[key]);
    });
    when(mock.keysChanged).thenAnswer((i) => keysChanged);
    return mock;
  }

  test('keys', () async {
    final gsettings = mockGioSettings(values: {
      'int32': 123,
      'string': 'foo',
      'array': ['foo', 'bar'],
    });

    final store = SettingsStore.of(gsettings);
    expect(store.keys, isEmpty);

    await store.init();
    expect(store.keys, ['int32', 'string', 'array']);
  });

  test('get', () async {
    final gsettings = mockGioSettings(values: {
      'int32': 123,
      'string': 'foo',
      'array': ['foo', 'bar'],
    });

    final store = SettingsStore.of(gsettings);
    expect(store.get('none'), isNull);
    expect(store.get('int32'), isNull);
    expect(store.get('string'), isNull);
    expect(store.get('array'), isNull);

    await store.init();
    expect(store.get('none'), isNull);
    expect(store.get('int32'), 123);
    expect(store.get('string'), 'foo');
    expect(store.get('array'), ['foo', 'bar']);
  });

  test('set', () async {
    final gsettings = mockGioSettings();
    final store = SettingsStore.of(gsettings);

    await store.set('int32', 123);
    verify(gsettings.set('int32', 123));

    await store.set('string', 'foo');
    verify(gsettings.set('string', 'foo'));

    await store.set('array', ['foo', 'bar']);
    verify(gsettings.set('array', ['foo', 'bar']));
  });

  test('unset', () async {
    final gsettings = mockGioSettings();
    final store = SettingsStore.of(gsettings);

    await store.unset('foo');
    verify(gsettings.unset('foo'));
  });

  test('change', () async {
    final keysChanged = StreamController<List<String>>(sync: true);

    final gsettings = mockGioSettings(
      values: {'foo': 'bar'},
      keysChanged: keysChanged.stream,
    );

    final store = SettingsStore.of(gsettings);

    var wasNotified = 0;
    store.addListener(() => ++wasNotified);

    await store.init();

    expect(wasNotified, 1);
    expect(store.get('foo'), 'bar');

    when(gsettings.get('foo')).thenAnswer((_) async => 'baz');

    final completer = Completer();
    store.addListener(() {
      if (!completer.isCompleted) {
        completer.complete(store.get('foo'));
      }
    });

    keysChanged.add(['foo']);

    expect(await completer.future, 'baz');
    expect(wasNotified, 2);
  });

  test('dispose', () async {
    final keysChanged = StreamController<List<String>>(sync: true);

    final gsettings = mockGioSettings(keysChanged: keysChanged.stream);

    final store = SettingsStore.of(gsettings);

    await store.init();
    expect(keysChanged.hasListener, isTrue);
    verifyNever(gsettings.close());

    await store.dispose();
    expect(keysChanged.hasListener, isFalse);
    verify(gsettings.close()).called(1);
  });
}
