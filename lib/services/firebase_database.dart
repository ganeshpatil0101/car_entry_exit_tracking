import 'package:car_entry_exit/model/car_entry_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabse {
  static Firestore _db = Firestore.instance;

  final CollectionReference carEntryList;
  final CollectionReference carExitList;
  final CollectionReference admins;
  final CollectionReference models;
  final userId;
  FirebaseDatabse(String userId)
      : this.carEntryList = _db.collection("Vehicles"),
        this.carExitList = _db.collection("VehiclesExit"),
        admins = _db.collection("admin"),
        models = _db.collection("models"),
        this.userId = userId;

  Future<QuerySnapshot> getCarEntryList() async {
    return carEntryList.getDocuments();
  }

  Future<List<DocumentSnapshot>> getModels() async {
    QuerySnapshot modelTypes = await models.getDocuments();
    return modelTypes.documents;
  }

  Future<QuerySnapshot> getAdmins() async {
    return await admins.getDocuments();
  }

  Stream<QuerySnapshot> getCarEntryListSnapshot() {
    return carEntryList
        .orderBy('dateIn', descending: true)
        .where("status", isEqualTo: "IN")
        .snapshots();
  }

  Stream<QuerySnapshot> getCarExitListSnapshot() {
    return carEntryList
        .orderBy('outDate', descending: true)
        .where("status", isEqualTo: "OUT")
        .snapshots();
  }

  Future<DocumentReference> addCarEntry(CarEntryData carEntryData) {
    return carEntryList.add(carEntryData.toJson(carEntryData));
  }

  Future<DocumentReference> exitCar(CarEntryData carExitData) {
    // TODO remove entry from Vehicle collection
    return carEntryList.add(carExitData.toJson(carExitData));
  }

  Future<void> deleteCarEntry(CarEntryData carEntryData) {
    return carEntryData.reference.delete();
  }

  String getUserId() {
    return this.userId;
  }
}
