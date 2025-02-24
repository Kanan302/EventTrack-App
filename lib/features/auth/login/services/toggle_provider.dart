import 'package:flutter/material.dart';

import '../../../../data/local/shared_preferences.dart';

class Toggle with ChangeNotifier {
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isRememberMe = false;
  bool get isRememberMe => _isRememberMe;
  final SharedPreferenceService _sharedPrefService = SharedPreferenceService();

  bool _isConfirmVisible = false;
  bool get isConfirmVisible => _isConfirmVisible;

  void toggleVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleRemember() async {
    _isRememberMe = !_isRememberMe;
    await _sharedPrefService.saveRememberMe(_isRememberMe);
    notifyListeners();
  }

  void toggleConfirm() {
    _isConfirmVisible = !_isConfirmVisible;
    notifyListeners();
  }
}