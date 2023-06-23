import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/blind_model.dart';

class BlindProvider extends ChangeNotifier {
  Blind currentBlind = Blind.defaultBlind();
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("Users/visual_impaireds/Blind");
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
    currentBlind.codeBlind = '';
    //currentBlind.altitud = position.longitude.toString();
    //currentBlind.latitud = position.latitude.toString();
    currentBlind.parentListAcepted = [];
    currentBlind.parentListRequested = [];

    //print(currentBlind.altitud);
    //print(currentBlind.latitud);
    notifyListeners();
  }

  postNewBlindUser(Blind newBlind) async {
    ref.set({
      'name': newBlind.name,
      'codeBlind': newBlind.codeBlind, //TODO: CAMBIAR MAS ADELANTE
      'altitud': currentBlind.altitud,
      'latitud': currentBlind.latitud,
      'parentListAcepted': newBlind.parentListAcepted,
      'parentListRequested': newBlind.parentListRequested
    });
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
}
