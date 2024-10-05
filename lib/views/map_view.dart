import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:baston_inteligente_mejorada/services/blind_provider.dart';
import 'package:baston_inteligente_mejorada/themes/themes.dart';
import '../blocs/blocs.dart';

class MapView extends StatelessWidget {
  final BlindProvider blindProvider;
  final LocationBloc locationBloc;

  const MapView({
    super.key,
    required this.blindProvider,
    required this.locationBloc,
  });

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(
        double.parse(blindProvider.currentBlind.latitud),
        double.parse(blindProvider.currentBlind.altitud),
      ),
      zoom: 15,
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) =>
            mapBloc.add(OnStopFollowingUserEvent()),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          style: jsonEncode(uberMapTheme),
          onMapCreated: (controller) =>
              mapBloc.add(OnMapInitializedEvent(controller)),
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
        ),
      ),
    );
  }
}
