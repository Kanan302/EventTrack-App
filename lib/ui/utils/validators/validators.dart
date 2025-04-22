import 'package:intl/intl.dart';

class Validators {
  static String? isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Daxil edin';
    }
    return null;
  }

  static String? writeMail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-poçt ünvanınızı daxil edin';
    } else if (!value.contains('@')) {
      return 'E-poçt ünvanında "@" işarəsi olmalıdır';
    }
    return null;
  }

  static String? writePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifrənizi daxil edin';
    } else if (value.length < 6) {
      return 'Şifrə ən azı 6 simvoldan ibarət olmalıdır';
    }
    return null;
  }

  static String? writeName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Adınızı daxil edin';
    }
    return null;
  }

  static String? writeEventCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zəhmət olmasa, tədbirin şəhərini daxil edin';
    }
    return null;
  }

  static String? writeEventDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zəhmət olmasa, tədbirin təsvirini daxil edin';
    }
    return null;
  }

  static String? writeEventName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zəhmət olmasa, tədbirin adını daxil edin';
    }
    return null;
  }

  static String? writeEventStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zəhmət olmasa, tədbirin küçəsini daxil edin';
    }
    return null;
  }

  static String? validateDateTimeFormat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zəhmət olmasa, tarixi seçin';
    }

    try {
      DateFormat("dd.MM.yyyy HH:mm").parseStrict(value);
    } catch (e) {
      return 'Tarixi düzgün formatda daxil edin (dd.MM.yyyy HH:mm)';
    }

    return null;
  }
}
