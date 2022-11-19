import 'package:flutter/widgets.dart';

class TabItem extends ChangeNotifier {
  TabItem([this._name]);

  String? _name;
  final focusScope = FocusScopeNode();

  String? get name => _name;
  set name(String? name) {
    if (_name == name) return;
    _name = name;
    notifyListeners();
  }

  @override
  void dispose() {
    focusScope.dispose();
    super.dispose();
  }
}
