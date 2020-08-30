import 'package:car_entry_exit/model/car_entry_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabse {
  static Firestore _db = Firestore.instance;

  final CollectionReference carEntryList;
  final CollectionReference serviceTypes;
  final CollectionReference models;

  FirebaseDatabse() : this.carEntryList = _db.collection("Vehicles"),
  serviceTypes = _db.collection("servicetype"),models = _db.collection("models");


  Future<QuerySnapshot> getCarEntryList() async {
    return carEntryList.getDocuments();
  }

 Future<List<DocumentSnapshot>> getModels() async {
    QuerySnapshot modelTypes =  await models.getDocuments();
    return modelTypes.documents;
  }
  Future<QuerySnapshot> getServiceTypes() async {
    return await serviceTypes.getDocuments();
  }

  Stream<QuerySnapshot> getCarEntryListSnapshot() {
    return carEntryList.orderBy('datein', descending: true).snapshots();
  }


  Future<DocumentReference> addCarEntry(CarEntryData carEntryData) {
    return carEntryList.add(carEntryData.toJson(carEntryData));
  }



}
