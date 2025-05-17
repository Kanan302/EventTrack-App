import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../generated/l10n/app_localizations.dart';

class CreateEventMapService {
  // Xəritədə seçilən nöqtəyə əsasən ünvan məlumatlarını alır
  static Future<void> handleMapTap({
    required LatLng latlng,
    required TextEditingController cityController,
    required TextEditingController streetController,
    required ValueNotifier<String?> addressNotifier,
    required ValueNotifier<String?> locationErrorNotifier,
    required ValueNotifier<String?> cityNotifier,
    required ValueNotifier<String?> streetNotifier,
    required Function(LatLng) onLocationSelected,
  }) async {
    locationErrorNotifier.value = null;

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latlng.latitude,
        latlng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        List<String> parts = [];
        if ((place.street ?? '').isNotEmpty) {
          parts.add(place.street!);
          streetNotifier.value = place.street;
          streetController.text = place.street!;
        }
        if ((place.locality ?? '').isNotEmpty) {
          parts.add(place.locality!);
          cityNotifier.value = place.locality;
          cityController.text = place.locality!;
        }
        if ((place.country ?? '').isNotEmpty) {
          parts.add(place.country!);
        }

        addressNotifier.value = parts.join(', ');
      }
    } catch (e) {
      debugPrint("Ünvan alınarkən xəta baş verdi: $e");
    }

    onLocationSelected(latlng);
  }

  // Ünvanı axtarır və tapılan koordinatlara xəritəni hərəkət etdirir
  static Future<void> searchAddress({
    required BuildContext context,
    required String query,
    required MapController mapController,
    required TextEditingController cityController,
    required TextEditingController streetController,
    required ValueNotifier<String?> addressNotifier,
    required ValueNotifier<String?> locationErrorNotifier,
    required ValueNotifier<String?> cityNotifier,
    required ValueNotifier<String?> streetNotifier,
    required Function(LatLng) onLocationSelected,
    required Function(LatLng) updateSelectedLocation,
  }) async {
    if (query.trim().isEmpty) return;

    try {
      final List<geocoding.Location> locations = await locationFromAddress(
        query,
      );
      if (locations.isNotEmpty) {
        final location = locations.first;
        final latLng = LatLng(location.latitude, location.longitude);

        mapController.move(latLng, 15);
        updateSelectedLocation(latLng);

        await handleMapTap(
          latlng: latLng,
          cityController: cityController,
          streetController: streetController,
          addressNotifier: addressNotifier,
          locationErrorNotifier: locationErrorNotifier,
          cityNotifier: cityNotifier,
          streetNotifier: streetNotifier,
          onLocationSelected: onLocationSelected,
        );
      } else {
        locationErrorNotifier.value =
            AppLocalizations.of(context).addressNotFound;
      }
    } catch (e) {
      locationErrorNotifier.value = AppLocalizations.of(context).searchError;
      debugPrint('Axtarış zamanı xəta: $e');
    }
  }
}
