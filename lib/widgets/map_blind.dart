import 'package:baston_inteligente_mejorada/providers/blind_provider.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  final BlindProvider blindProvider;
  const MapScreen({super.key, required this.blindProvider});

  @override
  MapaBlindScreen createState() => MapaBlindScreen();
}

class MapaBlindScreen extends State<MapScreen> {
  //late GoogleMapController mapController;
  //LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchLocation() async {
    //Location location = Location();

    //currentLocation = await location.getLocation();
    setState(() {
      // Actualiza el estado para reflejar la ubicación actual
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        centerTitle: true,
      ),
      /*body: GoogleMap(
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
      ),*/
    );
  }
}
