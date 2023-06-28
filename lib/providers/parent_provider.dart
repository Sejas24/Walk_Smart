import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/blind_model.dart';
import '../model/parent_model.dart';

class ParentProvider extends ChangeNotifier {
  Parent currentParent = Parent.defaultParent();
  Blind blind = Blind.defaultBlind();

  final CollectionReference parentCollection =
      FirebaseFirestore.instance.collection('parents');
  final CollectionReference blindCollection =
      FirebaseFirestore.instance.collection('blinds');

  Future<void> postNewParentUser(Parent parent) async {
    try {
      await parentCollection.add({
        'name': parent.name,
        'lastName': parent.lastName,
        'email': parent.email,
        'codeBlind': parent.codeBlind,
        'cellphone': parent.cellPhone
      }).then((value) => {print("Parent has been posted")});
    } catch (e) {
      throw Exception('Error al agregar el nuevo usuario Blind: $e');
    }
  }

  Future<Blind> getBlindByEmail(String email) async {
    await blindCollection
        .where('email', isEqualTo: email)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        final data = value.docs.first.data() as Map<String, dynamic>;
        return Blind(
          documentId: value.docs.first.id,
          name: data['name'] ?? '',
          lastName: data['lastName'] ?? '',
          email: data['email'] ?? '',
          codeBlind: data['codeBlind'] ?? '',
          altitud: data['altitud'] ?? '',
          latitud: data['latitud'] ?? '',
        );
      }
    });

    return Future.error(
        Exception("No se encontró el Blind con el codeBlind especificado."));
  }

  Future<Blind> getBlindByCode(String codeBlind) async {
    try {
      final snapshot = await blindCollection
          .where('codeBlind', isEqualTo: codeBlind)
          .limit(1)
          .get();

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

      throw Exception('No se encontró el Blind con el codeBlind especificado.');
    } catch (e) {
      throw Exception('Error al obtener el Blind desde Firebase: $e');
    }
  }

  Future<Parent> getParentByEmail(String email) async {
    try {
      final snapshot = await parentCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;

        return Parent(
            documentId: snapshot.docs.first.id,
            name: data['name'] ?? '',
            lastName: data['lastName'] ?? '',
            email: data['email'] ?? '',
            codeBlind: data['codeBlind'] ?? '',
            cellPhone: data['cellphone'] ?? '');
      }

      throw Exception('No se encontró el Parent con el email especificado.');
    } catch (e) {
      throw Exception('Error al obtener el Parent desde Firebase: $e');
    }
  }

  Future<void> updateParentCodeBlindByBlindCode(String blindCode) async {
    try {
      // Obtener el Blind por su codeBlind
      blind = await getBlindByCode(blindCode);

      // Si el Blind existe, buscar el Parent por su email
      if (blind != null) {
        final parent = await getParentByEmail(currentParent.email);

        // Actualizar el campo codeBlind del Parent
        if (parent != null) {
          parent.codeBlind = blindCode;

          // Actualizar el Parent en la base de datos
          await parentCollection
              .doc(parent.documentId)
              .update({'codeBlind': blindCode});
        } else {
          throw Exception(
              'No se encontró el Parent asociado al Blind con el codeBlind especificado.');
        }
      } else {
        throw Exception(
            'No se encontró el Blind con el codeBlind especificado.');
      }
    } catch (e) {
      throw Exception('Error al actualizar el campo codeBlind del Parent: $e');
    }
  }

  Future<void> saveParentProfileData(Parent parent, documentID) async {
    final Map<String, dynamic> parentdData = {
      'name': parent.name,
      'lastName': parent.lastName,
      'codeBlind': parent.codeBlind,
      'email': parent.email,
      'cellphone': parent.cellPhone
    };
    await parentCollection.doc(documentID).set(parentdData);
  }

  Future<void> deleteParentAccount(context, String documentID) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      // Eliminar documento de Firestore
      await parentCollection.doc(documentID).delete();

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

  Future<LatLng> getParentLocation() async {
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

  Future<void> getParentPosition() async {
    try {
      LatLng currentLocation = await getParentLocation();

      //TODO Revisar esta parte del codigo para utilizar la altitud y latitud del ciego

      // currentBlind.altitud = currentLocation.longitude.toString();
      // currentBlind.latitud = currentLocation.latitude.toString();

      notifyListeners();
    } catch (e) {
      print('Error al obtener la ubicación: $e');
      // Manejar el error según sea necesario
    }
  }
}
