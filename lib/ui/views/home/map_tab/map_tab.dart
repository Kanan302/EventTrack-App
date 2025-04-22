import 'package:ascca_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../cubits/events/get_events/get_events_cubit.dart';
import '../../../utils/messages/messages.dart';
import '../widgets/map_widget.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  final MapController _mapController = MapController();
  String? _selectedLocationName;

  @override
  void initState() {
    super.initState();
    context.read<GetEventsCubit>().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetEventsCubit, GetEventsState>(
        builder: (context, state) {
          if (state is GetEventsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetEventsFailure) {
            return Center(
              child: Text('${Messages.error} ${state.errorMessage}'),
            );
          }

          if (state is GetEventsSuccess) {
            final validEvents =
                state.events
                    .where((event) => event.lat != null && event.lng != null)
                    .toList();

            final markers =
                validEvents.map((event) {
                  final point = LatLng(
                    double.parse(event.lat!),
                    double.parse(event.lng!),
                  );

                  final isSelected = _selectedLocationName == event.name;

                  return Marker(
                    width: isSelected ? 60 : 40,
                    height: isSelected ? 60 : 40,
                    point: point,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLocationName = event.name;
                        });
                      },
                      child: Icon(
                        Icons.location_on,
                        size: isSelected ? 60 : 40,
                        color: AppColors.red,
                      ),
                    ),
                  );
                }).toList();

            return Stack(
              children: [
                MapWidget(
                  mapController: _mapController,
                  markers: markers,
                  height: MediaQuery.of(context).size.height,
                ),
                if (_selectedLocationName != null)
                  Positioned(
                    top: 70,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
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
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
