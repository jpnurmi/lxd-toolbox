import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesModel extends SafeChangeNotifier {
  PreferencesModel(this._preferences);

  final SharedPreferences _preferences; // ignore: unused_field

  Future<void> init() async {
    _theme = _preferences.getString('theme');
  }

  String? get theme => _theme;
  String? _theme;
  void setTheme(String? value) {
    if (value == _theme) return;
    _theme = value;
    if (value != null) {
      _preferences.setString('theme', value);
    } else {
      _preferences.remove('theme');
    }
    notifyListeners();
  }
}
