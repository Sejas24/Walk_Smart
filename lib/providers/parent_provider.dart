import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/blind_model.dart';
import '../model/parent_model.dart';

class ParentProvider extends ChangeNotifier {
  Parent currentParent = Parent.defaultParent();
  Blind blind = Blind.defaultBlind();

  final CollectionReference parentCollection =
      FirebaseFirestore.instance.collection('parents');
  final CollectionReference blindCollection =
      FirebaseFirestore.instance.collection('blinds');

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

  Future<void> postNewParentUser(Parent parent) async {
    try {
      await parentCollection.add({
        'name': parent.name,
        'lastName': parent.lastName,
        'email': parent.email,
        'codeBlind': parent.codeBlind,
        'cellphone': parent.cellphone
      }).then((value) => {print("Parent has been posted")});
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

  Future<Blind> getBlindByCode(String codeBlind) async {
    print("GET BLIND BY CODE" + codeBlind);
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
    print("GET PARENT BY EMAIL" + email);

    try {
      final snapshot = await parentCollection
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;

        print("GET PARENT BY EMAIL" + data.toString());
        return Parent(
            documentId: snapshot.docs.first.id,
            name: data['name'] ?? '',
            lastName: data['lastName'] ?? '',
            email: data['email'] ?? '',
            codeBlind: data['codeBlind'] ?? '',
            cellphone: data['cellphone'] ?? '');
      }

      throw Exception('No se encontró el Parent con el email especificado.');
    } catch (e) {
      throw Exception('Error al obtener el Parent desde Firebase: $e');
    }
  }

  Future<void> updateParentCodeBlindByBlindCode(String blindCode) async {
    print("UPDATE parent" + blindCode);
    try {
      // Obtener el Blind por su codeBlind
      blind = await getBlindByCode(blindCode);

      // Si el Blind existe, buscar el Parent por su email
      print("111111111" + currentParent.email);
      if (blind != null) {
        final parent = await getParentByEmail(currentParent.email);

        print("222222222" + parent.documentId);

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
}
