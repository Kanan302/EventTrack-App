import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../generated/l10n/app_localizations.dart';
import '../../../../../shared/theme/app_colors.dart';
import '../../widgets/map_widget.dart';
import '../service/create_event_map_service.dart';

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
  final TextEditingController searchController = TextEditingController();
  LatLng? _selectedLocation;
  bool _isSearchOpen = false;

  void _handleMapTap(TapPosition tapPosition, LatLng latlng) {
    CreateEventMapService.handleMapTap(
      latlng: latlng,
      cityController: widget.cityController,
      streetController: widget.streetController,
      addressNotifier: widget.addressNotifier,
      locationErrorNotifier: widget.locationErrorNotifier,
      cityNotifier: widget.cityNotifier,
      streetNotifier: widget.streetNotifier,
      onLocationSelected: (location) {
        setState(() {
          _selectedLocation = location;
        });
        widget.onLocationSelected(location);
      },
    );
  }

  Future<void> _searchAddress() async {
    await CreateEventMapService.searchAddress(
      context: context,
      query: searchController.text,
      mapController: _mapController,
      cityController: widget.cityController,
      streetController: widget.streetController,
      addressNotifier: widget.addressNotifier,
      locationErrorNotifier: widget.locationErrorNotifier,
      cityNotifier: widget.cityNotifier,
      streetNotifier: widget.streetNotifier,
      onLocationSelected: widget.onLocationSelected,
      updateSelectedLocation: (location) {
        setState(() {
          _selectedLocation = location;
        });
      },
    );
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
        Text(
          AppLocalizations.of(context).choosePlaceFromMap,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            MapWidget(
              mapController: _mapController,
              onTap: _handleMapTap,
              markers: markers,
              height: 300,
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isSearchOpen)
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        style: TextStyle(color: AppColors.black),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).searchHint,
                          hintStyle: TextStyle(color: AppColors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                  IconButton(
                    icon: Icon(
                      _isSearchOpen ? Icons.search : Icons.search_outlined,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      if (_isSearchOpen && searchController.text.isNotEmpty) {
                        _searchAddress();
                      }
                      setState(() {
                        _isSearchOpen = true;
                      });
                    },
                  ),
                  if (_isSearchOpen)
                    GestureDetector(
                      child: const Icon(Icons.close, color: AppColors.black),
                      onTap: () {
                        setState(() {
                          _isSearchOpen = false;
                          searchController.clear();
                        });
                      },
                    ),
                ],
              ),
            ),
          ],
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
                  '${AppLocalizations.of(context).coordinates}'
                  'Lat: ${_selectedLocation!.latitude.toStringAsFixed(5)}, '
                  'Lng: ${_selectedLocation!.longitude.toStringAsFixed(5)}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '${AppLocalizations.of(context).address}: $address',
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
                style: const TextStyle(color: AppColors.red, fontSize: 14),
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
    searchController.dispose();
    super.dispose();
  }
}
