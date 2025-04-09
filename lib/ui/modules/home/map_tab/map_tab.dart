import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final MapController _mapController = MapController();
  double _currentZoom = 12.0;

  final Map<String, LatLng> locations = {
    'Baku Center': LatLng(40.409264, 49.867092),
    'Old City': LatLng(40.3772, 49.8528),
    'Flame Towers': LatLng(40.3947, 49.8822),
    'Fountain Square': LatLng(40.4098, 49.8452),
    'Baku Boulevard': LatLng(40.3636, 49.8372),
  };

  String? _selectedLocationName;

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(40.409264, 49.867092),
                initialZoom: _currentZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers:
                      locations.entries.map((entry) {
                        final isSelected = _selectedLocationName == entry.key;

                        return Marker(
                          width: isSelected ? 60.0 : 40.0,
                          height: isSelected ? 60.0 : 40.0,
                          point: entry.value,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedLocationName = entry.key;
                              });
                            },
                            child: Icon(
                              Icons.location_on,
                              size: isSelected ? 60 : 40,
                              color: AppColors.red,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),

            if (_selectedLocationName != null)
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    _selectedLocationName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
                  FloatingActionButton(
                    mini: true,
                    onPressed: _zoomIn,
                    child: const Icon(Icons.zoom_in),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    mini: true,
                    onPressed: _zoomOut,
                    child: const Icon(Icons.zoom_out),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
