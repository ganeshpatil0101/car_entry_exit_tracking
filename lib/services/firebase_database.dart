import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabse {
  static Firestore _db = Firestore.instance;

  final CollectionReference carEntryList;

  FirebaseDatabse() : this.carEntryList = _db.collection("carEntryList");

  Future<QuerySnapshot> getCarEntryList() async {
    return carEntryList.getDocuments();
  }

  Stream<QuerySnapshot> getCarEntryListSnapshot() {
    return carEntryList.orderBy('createdDate', descending: true).snapshots();
  }
}
