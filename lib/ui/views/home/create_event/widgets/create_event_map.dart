import 'package:ascca_app/shared/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../shared/theme/app_colors.dart';
import '../../widgets/map_widget.dart';

class CreateEventMap extends StatefulWidget {
  final ValueNotifier<String?> addressNotifier;
  final ValueNotifier<String?> locationErrorNotifier;
  final ValueNotifier<String?> cityNotifier;
  final ValueNotifier<String?> streetNotifier;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final Function(LatLng) onLocationSelected;

  const CreateEventMap({
    super.key,
    required this.addressNotifier,
    required this.locationErrorNotifier,
    required this.cityNotifier,
    required this.streetNotifier,
    required this.cityController,
    required this.streetController,
    required this.onLocationSelected,
  });

  @override
  State<CreateEventMap> createState() => _CreateEventMapState();
}

class _CreateEventMapState extends State<CreateEventMap> {
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;

  void _handleMapTap(TapPosition tapPosition, LatLng latlng) async {
    _selectedLocation = latlng;
    widget.locationErrorNotifier.value = null;

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
          widget.streetNotifier.value = place.street;
          widget.streetController.text = place.street!;
        }
        if ((place.locality ?? '').isNotEmpty) {
          parts.add(place.locality!);
          widget.cityNotifier.value = place.locality;
          widget.cityController.text = place.locality!;
        }
        if ((place.country ?? '').isNotEmpty) {
          parts.add(place.country!);
        }

        widget.addressNotifier.value = parts.join(', ');
      }
    } catch (e) {
      debugPrint("Ünvan alınarkən xəta baş verdi: $e");
    }

    widget.onLocationSelected(_selectedLocation!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final markers =
        _selectedLocation == null
            ? <Marker>[]
            : [
              Marker(
                width: 50,
                height: 50,
                point: _selectedLocation!,
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.lavenderBlue,
                  size: 40,
                ),
              ),
            ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppTexts.choosePlaceFromMap,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        MapWidget(
          mapController: _mapController,
          onTap: _handleMapTap,
          markers: markers,
          height: 250,
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<String?>(
          valueListenable: widget.addressNotifier,
          builder: (context, address, _) {
            if (address == null || _selectedLocation == null) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppTexts.coordinates}'
                  'Lat: ${_selectedLocation!.latitude.toStringAsFixed(5)}, '
                  'Lng: ${_selectedLocation!.longitude.toStringAsFixed(5)}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppTexts.address}: $address',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
        ),
        ValueListenableBuilder<String?>(
          valueListenable: widget.locationErrorNotifier,
          builder: (context, error, _) {
            if (error == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
