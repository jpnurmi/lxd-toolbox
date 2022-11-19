import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:settings_store/settings_store.dart';

import 'hive_settings_store_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  MockBox mockBox({
    Map<String, dynamic> values = const {},
    Stream<BoxEvent> events = const Stream.empty(),
  }) {
    final mock = MockBox();
    when(mock.keys).thenReturn(values.keys);
    when(mock.get(any)).thenAnswer((_) {
      final key = _.positionalArguments[0] as String;
      return values[key];
    });
    when(mock.watch()).thenAnswer((i) => events);
    return mock;
  }

  test('keys', () async {
    final box = mockBox(values: {
      'bool': true,
      'int32': 123,
      'double': 123.456,
      'string': 'foo',
      'array': ['foo', 'bar'],
    });

    final store = HiveSettingsStore.of(box);
    expect(store.keys, ['bool', 'int32', 'double', 'string', 'array']);
  });

  test('get', () async {
    final box = mockBox(values: {
      'bool': true,
      'int32': 123,
      'double': 123.456,
      'string': 'foo',
      'array': ['foo', 'bar'],
    });

    final store = HiveSettingsStore.of(box);
    expect(store.get('none'), isNull);
    expect(store.get('bool'), isTrue);
    expect(store.get('int32'), 123);
    expect(store.get('double'), 123.456);
    expect(store.get('string'), 'foo');
    expect(store.get('array'), ['foo', 'bar']);
  });

  test('set', () async {
    final box = mockBox();
    final store = HiveSettingsStore.of(box);

    await store.set('bool', true);
    verify(box.put('bool', true)).called(1);

    await store.set('int32', 123);
    verify(box.put('int32', 123));

    await store.set('double', 123.456);
    verify(box.put('double', 123.456));

    await store.set('string', 'foo');
    verify(box.put('string', 'foo'));

    await store.set('array', ['foo', 'bar']);
    verify(box.put('array', ['foo', 'bar']));
  });

  test('unset', () async {
    final box = mockBox();
    final store = HiveSettingsStore.of(box);

    await store.unset('foo');
    verify(box.delete('foo'));
  });

  test('change', () async {
    final events = StreamController<BoxEvent>(sync: true);

    final box = mockBox(
      values: {'foo': 'bar'},
      events: events.stream,
    );

    final store = HiveSettingsStore.of(box);

    var wasNotified = 0;
    store.addListener(() => ++wasNotified);

    await store.init();

    expect(wasNotified, 0);
    expect(store.get('foo'), 'bar');

    when(box.get('foo')).thenAnswer((_) async => 'baz');

    final completer = Completer();
    store.addListener(() {
      if (!completer.isCompleted) {
        completer.complete(store.get('foo'));
      }
    });

    events.add(BoxEvent('foo', 'baz', false));

    expect(await completer.future, 'baz');
    expect(wasNotified, 1);
  });

  test('dispose', () async {
    final events = StreamController<BoxEvent>(sync: true);

    final box = mockBox(events: events.stream);

    final store = HiveSettingsStore.of(box);

    await store.init();
    expect(events.hasListener, isTrue);
    verifyNever(box.close());

    await store.dispose();
    expect(events.hasListener, isFalse);
    verify(box.close()).called(1);
  });
}
