import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/blind_model.dart';

class BlindProvider extends ChangeNotifier {
  Blind currentBlind = Blind.defaultBlind();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference blindCollection =
      FirebaseFirestore.instance.collection('blinds');

  // DatabaseReference ref =
  //     FirebaseDatabase.instance.ref("Users/visual_impaireds/Blind");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
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
      }).then((value) => {print("holass")});
    } catch (e) {
      throw Exception('Error al agregar el nuevo usuario Blind: $e');
    }
  }

  Future<Blind> getBlindByCode(String code) async {
    try {
      final snapshot = await blindCollection
          .where('codeBlind', isEqualTo: code)
          .limit(1)
          .get()
          .then((value) {
            if (value.docs.isNotEmpty) {
              final data = value.docs.first.data() as Map<String, dynamic>;
              print("obtenido" + value.toString());
              return Blind(
                name: data['name'] ?? '',
                lastName: data['lastName'] ?? '',
                email: data['email'] ?? '',
                codeBlind: data['codeBlind'] ?? '',
                altitud: data['altitud'] ?? '',
                latitud: data['latitud'] ?? '',
              );
            }
          });

      throw Exception('No se encontró el Blind con el código especificado.');
    } catch (e) {
      throw Exception('Error al obtener el Blind desde Firebase: $e');
    }
  }

  Future<Blind> getBlindByEmail(String email) async {
    print("tttttttttttt" + email);
    try {
      final snapshot =
          await blindCollection.where('email', isEqualTo: email).limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        print("aaa" + data.toString());
        return Blind(
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
