import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gazzabko_admin_app/data/firebaseauth_provider.dart';
import 'package:gazzabko_admin_app/model/cart_item.dart';
import 'package:gazzabko_admin_app/model/notification.dart';
import 'package:gazzabko_admin_app/model/sales.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:gazzabko_admin_app/model/target.dart';
import 'package:gazzabko_admin_app/model/user.dart';

import './firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final _authProvider = FirebaseAuthProvider();

  Stream<List<User>> getUsers() => _firestoreProvider.getUsers().transform(
          StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<User> users = [];
        snapshot.documents.forEach((doc) {
          if (doc.data["accType"] != "admin") {
            users.add(parseJsonToUser(doc.data));
          }
        });
        sink.add(users);
      }));

  Future<void> saveUser(User user) async {
    AuthResult result =
        await _authProvider.createUser(user.email, "Sunshine60");
    return _firestoreProvider.saveUser(user, result.user.uid);
  }

  Stream<List<Shop>> getShops() => _firestoreProvider.getShops().transform(
          StreamTransformer<QuerySnapshot, List<Shop>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<Shop> shops = [];
        snapshot.documents.forEach((doc) {
          shops.add(parseJsonToShop(doc.data));
        });
        sink.add(shops);
      }));
  Future<void> saveShops(Shop shop) => _firestoreProvider.saveShops(shop);
  Future<void> updateShop(Map<String, dynamic> data) =>
      _firestoreProvider.updateShop(data);
  Future<void> deleteShop(String createdAt) =>
      _firestoreProvider.deleteShop(createdAt);
  Stream<List<AppNotifications>> getAppNotifications() =>
      _firestoreProvider.getAppNotifications().transform(
          StreamTransformer<QuerySnapshot, List<AppNotifications>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<AppNotifications> appNotifications = [];
        snapshot.documents.forEach((doc) {
          appNotifications.add(parseJsonToNotification(doc.data));
        });
        sink.add(appNotifications);
      }));
  Future<void> saveNotifications(AppNotifications notification) =>
      _firestoreProvider.saveNotifications(notification);
  Future<void> updateNotifications(Map<String, dynamic> newData) =>
      _firestoreProvider.updateNotifications(newData);
  Future<void> deleteNotifications(String sentDate) =>
      _firestoreProvider.deleteNotifications(sentDate);
  Stream<List<String>> getAreas() => _firestoreProvider.getAreas().transform(
          StreamTransformer<QuerySnapshot, List<String>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<String> areas = [];
        snapshot.documents.forEach((doc) {
          areas.add(doc.data['name']);
        });
        sink.add(areas);
      }));
  Stream<List<String>> getItems() => _firestoreProvider.getItems().transform(
          StreamTransformer<QuerySnapshot, List<String>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<String> items = [];
        snapshot.documents.forEach((doc) {
          items.add(doc.data['name']);
        });
        sink.add(items);
      }));
  Stream<List<Target>> getTargets() => _firestoreProvider.getTarget().transform(
          StreamTransformer<QuerySnapshot, List<Target>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<Target> targets = [];
        snapshot.documents.forEach((doc) {
          targets.add(parseJsonToTarget(doc.data));
        });
        sink.add(targets);
      }));

  Future<void> saveTargets(Target target) =>
      _firestoreProvider.saveTarget(target);
  Future<void> updateTargets(Map<String, dynamic> target) =>
      _firestoreProvider.updateTarget(target);
  Future<void> deleteTargets(String createdAt) =>
      _firestoreProvider.deleteTarget(createdAt);

  Stream<String> get onAuthStateChanged =>
      _authProvider.onAuthStateChanged.map((user) => user?.email);
  Stream<FirebaseUser> get getCurrentUser =>
      _authProvider.onAuthStateChanged.map((user) => user);
  Future<AuthResult> login(String email, String password) =>
      _authProvider.login(email, password);

  Stream<User> getUser(String email) => _firestoreProvider
          .getUser(email)
          .transform(StreamTransformer<DocumentSnapshot, User>.fromHandlers(
              handleData: (DocumentSnapshot snapshot, sink) {
        if (snapshot.exists) {
          sink.add(parseJsonToUser(snapshot.data));
        } else {
          sink.addError("No User Found");
        }
      }));
  Stream<List<Sales>> getSales(name) => _firestoreProvider
          .getSales(name)
          .transform(StreamTransformer<QuerySnapshot, List<Sales>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<Sales> sales = [];
        snapshot.documents.forEach((doc) {
          sales.add(parseJsonToSales(doc.data));
        });
        sink.add(sales);
      }));

  Future<void> deleteSalesData(String deliveryDate) =>
      _firestoreProvider.deleteSalesData(deliveryDate);

  Future<void> removeSalesItem(
          List<Map<String, dynamic>> clearedCart, String timeStamp) =>
      _firestoreProvider.removeSalesItem(clearedCart, timeStamp);

  Future<void> addSalesItem(
          List<Map<String, dynamic>> addedCart, String timeStamp) =>
      _firestoreProvider.addSalesItem(addedCart, timeStamp);

  Future<void> saveNewSales(String timeStamp, Map<String, dynamic> data) =>
      _firestoreProvider.saveNewSaleInfo(timeStamp, data);

  Stream<List<String>> getCartItems(String shopName) =>
      _firestoreProvider.getCartItems(shopName).transform(
          StreamTransformer<DocumentSnapshot, List<String>>.fromHandlers(
              handleData: (DocumentSnapshot snapshot, sink) {
        sink.add(parseJsonToShop(snapshot.data).items.toList());
      }));

  Stream<List<CartItem>> getSalesItems(String timeStamp) =>
      _firestoreProvider.getSalesItems(timeStamp).transform(
          StreamTransformer<DocumentSnapshot, List<CartItem>>.fromHandlers(
              handleData: (DocumentSnapshot snapshot, sink) {
        sink.add(parseJsonToSales(snapshot.data).items.asList());
      }));
  saveTokenDocument(Map<String, dynamic> data, String userEmail) =>
      _firestoreProvider.saveTokenDocument(data, userEmail);
  updateUser(String email, Map<String, dynamic> data) =>
      _firestoreProvider.updateUser(email, data);
  Future<dynamic> uploadFile(File image) => Future.value(0);

  Stream<String> getTodaysAttendance(String email, String code) =>
      _firestoreProvider.getTodaysAttendance(email, code).transform(
          StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
        if (snapshot.exists) {
          sink.add(snapshot.data["status"]);
        } else {
          sink.addError("absent");
        }
      }));

  Future<void> setAttendance(String email, String code) =>
      _firestoreProvider.setTodaysAttendance(email, code);
}
