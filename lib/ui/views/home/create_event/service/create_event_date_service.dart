import 'package:intl/intl.dart';

class CreateEventDateService {
  DateTime? startDate;
  DateTime? endDate;

  /// Tarixi `yyyy-MM-dd'T'HH:mm:ss` formatına çevirir
  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    return formatter.format(dateTime);
  }

  /// Başlanğıc tarixini təyin edir
  void setStartDate(DateTime date) {
    startDate = date;
  }

  /// Bitmə tarixini təyin edir
  void setEndDate(DateTime date) {
    endDate = date;
  }

  /// Formatlanmış başlanğıc tarixini alır
  String? get formattedStartDate => startDate != null ? formatDateTime(startDate!) : null;

  /// Formatlanmış bitmə tarixini alır
  String? get formattedEndDate => endDate != null ? formatDateTime(endDate!) : null;
}
