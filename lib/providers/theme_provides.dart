import 'package:flutter/foundation.dart';

class ThemeProvider extends ChangeNotifier{

  bool _isDark = false;

  void changeTheme(bool value){
    _isDark = value;
    notifyListeners();
  }

  bool getTheme() => _isDark;




}