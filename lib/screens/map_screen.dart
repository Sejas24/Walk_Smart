import 'package:baston_inteligente_mejorada/services/blind_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:baston_inteligente_mejorada/blocs/blocs.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  late BlindProvider blindProvider;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MapBloc(locationBloc: locationBloc), // Proveer MapBloc aquí
      child: Scaffold(
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
            if (locationState.lastKnowLocation == null) {
              return const Center(
                child: Text('Espere por Favor...'),
              );
            }

            return BlocBuilder<MapBloc, MapState>(
              builder: (context, mapState) {
                Map<String, Polyline> polylines = Map.from(mapState.polylines);
                if (!mapState.showMyRoute) {
                  polylines.removeWhere((key, value) => key == 'myRoute');
                }

                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      MapView(
                        blindProvider: blindProvider,
                        locationBloc: locationBloc,
                      ),
                      const SearchBarMap(),
                      const ManualMarker(),
                    ],
                  ),
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BtnToggleUserRoute(),
            BtnFollowUser(),
            BtnCurrentLocation(),
          ],
        ),
      ),
    );
  }
}
