import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/parent_model.dart';

class ParentProvider extends ChangeNotifier {
  Parent currentParent = Parent.defaultParent();
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("Users/visual_impaireds/Parent");
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  ParentProvider() {
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

    currentParent.name = '';
    currentParent.lastName = '';
    currentParent.codeBlind = '';
    currentParent.cellphone = 0;

    //print(currentParent.altitud);
    //print(currentParent.latitud);
    notifyListeners();
  }

  postNewParentUser(Parent newParent) async {
    ref.set({
      'name': newParent.name,
      'lastName': newParent.lastName,
      'codeParent': newParent.codeBlind, //TODO: CAMBIAR MAS ADELANTE
      'cellphone': newParent.cellphone
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
