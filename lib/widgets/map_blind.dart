import 'package:baston_inteligente_mejorada/providers/blind_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapBlindScreen extends StatefulWidget {
  final BlindProvider blindProvider;
  const MapBlindScreen({Key? key, required this.blindProvider})
      : super(key: key);

  @override
  _MapBlindScreenState createState() => _MapBlindScreenState();
}

class _MapBlindScreenState extends State<MapBlindScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        centerTitle: true,
        leading: const Icon(null),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              currentLocation?.latitude ?? 0,
              currentLocation?.longitude ??
                  0), // Utiliza la ubicación actual como destino inicial
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        myLocationEnabled: true, // Habilita la capa de ubicación en el mapa
        onTap: (LatLng latLng) {
          // Manejar el evento de toque en el mapa
          // Puedes implementar tu lógica aquí, como guardar la ubicación tocada, etc.
          print('Ubicación tocada: ${latLng.latitude}, ${latLng.longitude}');
        },
      ),
    );
  }
}
