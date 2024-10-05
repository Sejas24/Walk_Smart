import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/blind_provider.dart';
import '../themes/themes.dart';

import 'package:location/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

class MapBlindScreen extends StatefulWidget {
  final BlindProvider blindProvider;
  const MapBlindScreen({Key? key, required this.blindProvider})
      : super(key: key);

  @override
  MapBlindScreenState createState() => MapBlindScreenState();
}

class MapBlindScreenState extends State<MapBlindScreen> {
  late GoogleMapController mapController;
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchLocation() async {
    try {
      LatLng currentLocation = await widget.blindProvider.getBlindLocation();

      setState(() {
        this.currentLocation = LocationData.fromMap({
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
        });
      });

      widget.blindProvider.getBlindPosition();
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      // Manejar el error según sea necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    // final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(
        currentLocation?.latitude ?? 0,
        currentLocation?.longitude ?? 0,
      ), // Utiliza la ubicación actual como destino inicial
      zoom: 12,
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        // onPointerMove: (pointerMoveEvent) =>
        // mapBloc.add(OnStopFollowingUserEvent()),
        child:
            // body: GoogleMap(
            // initialCameraPosition: CameraPosition(
            // target: LatLng(
            // currentLocation?.latitude ?? 0,
            // currentLocation?.longitude ?? 0,
            // ), // Utiliza la ubicación actual como destino inicial
            // zoom: 12,
            // ),
            // onMapCreated: (GoogleMapController controller) {
            // mapController = controller;
            // },
            // myLocationEnabled: true, // Habilita la capa de ubicación en el mapa
            // onTap: (LatLng latLng) {
            // Manejar el evento de toque en el mapa
            // Puedes implementar tu lógica aquí, como guardar la ubicación tocada, etc.
            // print('Ubicación tocada: ${latLng.latitude}, ${latLng.longitude}');
            // },
            // ),
            GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          style: jsonEncode(
              uberMapTheme), // Habilita la capa de ubicación en el mapa
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          onTap: (LatLng latLng) {
            // Manejar el evento de toque en el mapa
            // Puedes implementar tu lógica aquí, como guardar la ubicación tocada, etc.
            print('Ubicación tocada: ${latLng.latitude}, ${latLng.longitude}');
          },
        ),
      ),
    );
  }
}
