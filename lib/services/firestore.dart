import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Officer Details
  final CollectionReference officerCollection =
      FirebaseFirestore.instance.collection('officers');

  // create
  Future<void> addOfficer(String officer) {
    return officerCollection
        .add({'Officer': officer, 'timestamp': Timestamp.now()});
  }

  // read

  // update
}
