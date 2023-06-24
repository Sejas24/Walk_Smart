import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List> getBlinds() async {
    List blind = [];
    CollectionReference collectionReferenceBlind = db.collection('blind');

    QuerySnapshot queryBlind = await collectionReferenceBlind.get();

    queryBlind.docs.forEach((documento) {
      blind.add(documento.data());
    });

    return blind;
  }
}
