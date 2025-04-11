import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final MapController mapController;
  final TapCallback? onTap;
  final Color? color;
  final List<Marker>? markers;
  final double? height;

  const MapWidget({
    super.key,
    required this.mapController,
    this.onTap,
    this.color,
    this.markers,
    this.height,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  double _currentZoom = 12.0;

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      widget.mapController.move(
        widget.mapController.camera.center,
        _currentZoom,
      );
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      widget.mapController.move(
        widget.mapController.camera.center,
        _currentZoom,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.height,
          child: FlutterMap(
            mapController: widget.mapController,
            options: MapOptions(
              initialCenter: LatLng(40.409264, 49.867092),
              initialZoom: _currentZoom,
              onTap: widget.onTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              if (widget.markers != null && widget.markers!.isNotEmpty)
                MarkerLayer(markers: widget.markers!),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Column(
            children: [
              FloatingActionButton(
                mini: true,
                onPressed: _zoomIn,
                child: const Icon(Icons.zoom_in),
              ),
              const SizedBox(height: 6),
              FloatingActionButton(
                mini: true,
                onPressed: _zoomOut,
                child: const Icon(Icons.zoom_out),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
