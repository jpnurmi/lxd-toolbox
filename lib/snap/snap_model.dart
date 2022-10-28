import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:platform/platform.dart';
import 'package:snapd/snapd.dart';

class SnapModel extends ChangeNotifier {
  SnapModel(
    this._snapd, {
    @visibleForTesting Platform platform = const LocalPlatform(),
  }) : _platform = platform;

  final SnapdClient _snapd;
  final Platform _platform;
  List<SnapConnection>? _connections;
  final _dismissed = <SnapConnection>{};

  String get appName => p.basename(_platform.resolvedExecutable);
  String? get snapName => _platform.environment['SNAP_NAME'];
  bool get isSnap => snapName == appName;
  bool get isReady => _connections != null;

  Future<void> init() async {
    await _snapd.loadAuthorization();
    return refresh();
  }

  bool isDismissed(SnapConnection connection) {
    return _dismissed.contains(connection);
  }

  bool isConnected(SnapConnection connection) {
    return _connections?.any((c) =>
            c.interface == connection.interface &&
            c.plug.plug == connection.plug.plug &&
            c.slot.slot == connection.slot.slot) ==
        true;
  }

  Future<void> connect(SnapConnection connection) async {
    try {
      await _snapd.connect(
        connection.plug.plug,
        connection.plug.interface ?? connection.interface,
        connection.slot.slot,
        connection.slot.interface ?? connection.interface,
      );
      return refresh();
    } on SnapdException catch (e) {
      debugPrint(e.toString());
    }
  }

  void dismiss(SnapConnection connection) {
    if (_dismissed.add(connection)) {
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    _connections =
        await _snapd.getConnections(snap: snapName!).then((r) => r.established);
    notifyListeners();
  }
}
