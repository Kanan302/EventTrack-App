import 'package:flutter/material.dart';
import '../../../../data/local/shared_preferences.dart';

class RememberMeNotifier extends ValueNotifier<bool> {
  final SharedPreferenceService _sharedPrefService = SharedPreferenceService();

  RememberMeNotifier() : super(true) {
    _loadRememberMe();
  }

  void toggleRemember() async {
    value = !value;
    await _sharedPrefService.saveRememberMe(value);
  }

  Future<void> _loadRememberMe() async {
    bool savedValue = await _sharedPrefService.readRememberMe();
    value = savedValue;
  }
}
