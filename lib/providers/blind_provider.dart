import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/blind_model.dart';

class BlindProvider extends ChangeNotifier {
  Blind currentBlind = Blind.defaultBlind();
  final CollectionReference blindCollection =
      FirebaseFirestore.instance.collection('blinds');

  BlindProvider() {
    declareVariables();
  }

  declareVariables() async {
    //bool serviceEnabled;
    /*LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

   /* final LocationOptions locationSettings = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );*/
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream()
            .listen((Position? position) {
      currentBlind.altitud = position!.latitude.toString();
      currentBlind.latitud = position.longitude.toString();
    });*/

    currentBlind.name = '';
    currentBlind.lastName = '';
    currentBlind.codeBlind = '';
    //currentBlind.altitud = position.longitude.toString();
    //currentBlind.latitud = position.latitude.toString();

    //print(currentBlind.altitud);
    //print(currentBlind.latitud);
    notifyListeners();
  }

  Future<void> postNewBlindUser(Blind blind) async {
    try {
      await blindCollection.add({
        'name': blind.name,
        'lastName': blind.lastName,
        'email': blind.email,
        'codeBlind': blind.codeBlind,
        'altitud': blind.altitud,
        'latitud': blind.latitud,
      }).then((value) => {print("blind has been posted")});
    } catch (e) {
      throw Exception('Error al agregar el nuevo usuario Blind: $e');
    }
  }

  Future<Blind> getBlindByEmail(String email) async {
    try {
      final snapshot =
          await blindCollection.where('email', isEqualTo: email).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        return Blind(
          documentId: snapshot.docs.first.id,
          name: data['name'] ?? '',
          lastName: data['lastName'] ?? '',
          email: data['email'] ?? '',
          codeBlind: data['codeBlind'] ?? '',
          altitud: data['altitud'] ?? '',
          latitud: data['latitud'] ?? '',
        );
      }

      throw Exception('No se encontró el Blind con el email especificado.');
    } catch (e) {
      throw Exception('Error al obtener el Blind desde Firebase: $e');
    }
  }
}
