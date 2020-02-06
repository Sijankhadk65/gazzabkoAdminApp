import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gazzabko_admin_app/model/notification.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:gazzabko_admin_app/model/target.dart';
import 'package:gazzabko_admin_app/model/user.dart';

class FirestoreProvider {
  final _firestoreInstance = Firestore.instance;

  Stream<QuerySnapshot> getUsers() {
    return _firestoreInstance.collection("users").snapshots();
  }

  Future<void> saveUser(User user, String uid) {
    var _user = convertUserToJson(user);
    _user.addEntries([MapEntry('uid', uid)]);
    return _firestoreInstance.document("users/${user.email}").setData(_user);
  }

  Future<void> updateUser(String email, Map<String, dynamic> newData) {
    return _firestoreInstance.document("users/$email").updateData(newData);
  }

  Stream<QuerySnapshot> getShops() {
    return _firestoreInstance.collection("shops").snapshots();
  }

  Future<void> saveShops(Shop shop) {
    return _firestoreInstance
        .document("shops/${shop.createdAt}")
        .setData(convertShopToJson(shop));
  }

  Future<void> updateShop(Map<String, dynamic> data) {
    return _firestoreInstance
        .document("shops/${data['createdAt']}")
        .updateData(data);
  }

  Future<void> deleteShop(String createdAt) {
    return _firestoreInstance.document("shops/$createdAt").delete();
  }

  Stream<DocumentSnapshot> getUser(String email) {
    return _firestoreInstance.document("users/$email").snapshots();
  }

  Stream<QuerySnapshot> getAppNotifications() {
    return _firestoreInstance.collection("notifications").snapshots();
  }

  Future<void> saveNotifications(AppNotifications notification) {
    return _firestoreInstance
        .document("notifications/${notification.sentDate}")
        .setData(convertAppNotificationToJson(notification));
  }

  Future<void> updateNotifications(Map<String, dynamic> newData) {
    return _firestoreInstance
        .document("notifications/${newData['sentDate']}")
        .updateData(newData);
  }

  Future<void> deleteNotifications(String sentDate) {
    return _firestoreInstance.document("notifications/$sentDate").delete();
  }

  Stream<QuerySnapshot> getAreas() {
    return _firestoreInstance.collection("areas").snapshots();
  }

  Stream<QuerySnapshot> getItems() {
    return _firestoreInstance.collection("items").snapshots();
  }

  Future<void> saveArea(Map<String, dynamic> area, String areaName) {
    return _firestoreInstance.document("shops/$areaName").setData(area);
  }

  Stream<QuerySnapshot> getTarget() {
    return _firestoreInstance.collection("target").snapshots();
  }

  Future<void> saveTarget(Target target) {
    return _firestoreInstance
        .document("target/${target.createdAt}")
        .setData(convertTargetToJson(target));
  }

  Future<void> updateTarget(Map<String, dynamic> data) {
    return _firestoreInstance
        .document("target/${data['createdAt']}")
        .updateData(data);
  }

  Future<void> deleteTarget(String createdAt) {
    return _firestoreInstance.document("target/$createdAt").delete();
  }

  Stream<QuerySnapshot> getSales(name) {
    return _firestoreInstance.collection("sales").snapshots();
  }

  Future<void> deleteSalesData(String deliveryDate) {
    return _firestoreInstance.document("sales/$deliveryDate").delete();
  }

  Future<void> removeSalesItem(
      List<Map<String, dynamic>> clearedCart, String timeStamp) {
    return _firestoreInstance
        .document("sales/$timeStamp")
        .updateData({"items": clearedCart});
  }

  Future<void> addSalesItem(
      List<Map<String, dynamic>> addedCart, String timeStamp) {
    return _firestoreInstance
        .document("sales/$timeStamp")
        .updateData({"items": addedCart});
  }

  Stream<DocumentSnapshot> getCartItems(String shopName) {
    return _firestoreInstance.document("shops/$shopName").snapshots();
  }

  Future<void> saveNewSaleInfo(String timeStamp, Map<String, dynamic> data) {
    return _firestoreInstance.document("sales/$timeStamp").setData(data);
  }

  Stream<DocumentSnapshot> getSalesItems(String timeStamp) {
    return _firestoreInstance.document("sales/$timeStamp").snapshots();
  }

  saveTokenDocument(Map<String, dynamic> data, String userEmail) {
    return _firestoreInstance
        .document("users/$userEmail")
        .collection("tokens")
        .document(data['token'])
        .setData(data);
  }

  // Future<void> deleteUser(String email) {
  //   return _firestoreInstance.document("users/$email").delete();
  // }

  Stream<DocumentSnapshot> getTodaysAttendance(String email, String code) {
    return _firestoreInstance
        .document("users/$email")
        .collection("attendance")
        .document("$code")
        .snapshots();
  }

  Future<void> setTodaysAttendance(String email, String code) {
    return _firestoreInstance
        .document("users/$email")
        .collection("attendance")
        .document("$code")
        .setData({"status": "present"});
  }
}
