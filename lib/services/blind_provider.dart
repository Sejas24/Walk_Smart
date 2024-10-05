import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/blind_model.dart';

class BlindProvider extends ChangeNotifier {
  Blind currentBlind = Blind.defaultBlind();
  final CollectionReference blindCollection =
      FirebaseFirestore.instance.collection('blinds');

  Future<void> postNewBlindUser(Blind blind) async {
    try {
      await blindCollection.add({
        'name': blind.name,
        'lastName': blind.lastName,
        'email': blind.email,
        'codeBlind': blind.codeBlind,
        'altitud': blind.altitud,
        'latitud': blind.latitud,
      }).then((value) => {debugPrint("blind has been posted")});
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

  Future<void> saveBlindProfileData(Blind blind, documentID) async {
    final Map<String, dynamic> blindData = {
      'name': blind.name,
      'lastName': blind.lastName,
      'codeBlind': blind.codeBlind,
      'email': blind.email,
    };
    await blindCollection.doc(documentID).set(blindData);
  }

  Future<void> deleteBlindAccount(context, String documentID) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      // Eliminar documento de Firestore
      await blindCollection.doc(documentID).delete();

      // Eliminar cuenta de autenticación
      final User? user = auth.currentUser;
      await user?.delete();

      // Navegar a la pantalla de inicio de sesión después de eliminar la cuenta
      Navigator.pushReplacementNamed(context, 'login');
    } catch (e) {
      print('Error al eliminar la cuenta: $e');
      // Manejar el error según sea necesario
    }
  }

  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, 'login');
    } catch (e) {
      print('Error al cerrar sesión: $e');
      // Manejar el error según sea necesario
    }
  }

  //Google Maps

  Future<LatLng> getBlindLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return LatLng(position.latitude, position.longitude);
  }

  Future<void> getBlindPosition() async {
    try {
      LatLng currentLocation = await getBlindLocation();

      currentBlind.altitud = currentLocation.longitude.toString();
      currentBlind.latitud = currentLocation.latitude.toString();

      notifyListeners();
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      // Manejar el error según sea necesario
    }
  }
}
