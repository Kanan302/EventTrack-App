import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n/app_localizations.dart';

class Validators {
  static String? isEmpty(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterValue;
    }
    return null;
  }

  static String? writeMail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterEmail;
    } else if (!value.contains('@')) {
      return AppLocalizations.of(context).invalidEmail;
    }
    return null;
  }

  static String? writePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterPassword;
    } else if (value.length < 6) {
      return AppLocalizations.of(context).shortPassword;
    }
    return null;
  }

  static String? writeName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterName;
    }
    return null;
  }

  static String? writeEventCity(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterEventCity;
    }
    return null;
  }

  static String? writeEventDescription(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterEventDescription;
    }
    return null;
  }

  static String? writeEventName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterEventName;
    }
    return null;
  }

  static String? writeEventStreet(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).enterEventStreet;
    }
    return null;
  }

  static String? validateDateTimeFormat(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context).selectDate;
    }

    try {
      DateFormat("dd.MM.yyyy HH:mm").parseStrict(value);
    } catch (e) {
      return AppLocalizations.of(context).invalidDateFormat;
    }

    return null;
  }
}
