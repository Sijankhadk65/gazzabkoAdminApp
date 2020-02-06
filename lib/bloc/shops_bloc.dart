import 'dart:async';

import 'package:gazzabko_admin_app/data/repository.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:rxdart/rxdart.dart';

class ShopsBloc {
  final _repo = Repository();
  List<String> areasList = [];
  List<String> itemsList = [];
  List<String> shopItemList = [];
  final _shopsSubject = BehaviorSubject<List<Shop>>();
  Function(List<Shop>) get changeShops => _shopsSubject.sink.add;
  Stream<List<Shop>> get shops => _shopsSubject.stream;

  final _selectedAreaSubject = BehaviorSubject<String>();
  Function(String) get changeArea => _selectedAreaSubject.sink.add;
  Stream<String> get area => _selectedAreaSubject.stream;

  final _selectedItemSubject = BehaviorSubject<String>();
  Function(String) get changeItem => _selectedItemSubject.sink.add;
  Stream<String> get item => _selectedItemSubject.stream;

  final _itemsListSubject = BehaviorSubject<List<String>>();
  Function(List<String>) get changeItemsList => _itemsListSubject.sink.add;
  Stream<List<String>> get items => _itemsListSubject.stream;

  final _nameSubject = BehaviorSubject<String>();
  Function(String) get changeName => _nameSubject.sink.add;
  Stream<String> get name => _nameSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String name, sink) {
        if (name != "") {
          sink.add(name);
        } else {
          sink.addError("Empty");
        }
      }));

  addItemsToShop() {
    if (!shopItemList.contains(_selectedItemSubject.value)) {
      shopItemList.add(_selectedItemSubject.value);
      changeItemsList(shopItemList);
    }
  }

  appendItemsToShop() {
    if (!shopItemList.contains(_selectedItemSubject.value)) {
      print("Doesn't Contain");
      shopItemList = _itemsListSubject.value.toList();
      shopItemList.add(_selectedItemSubject.value);
      changeItemsList(shopItemList);
    } else {
      print("Contains");
    }
  }

  ShopsBloc() {
    _repo.getShops().listen((shops) {
      changeShops(shops);
    });
    getAreas();
    getItems();
  }

  getAreas() {
    _repo.getAreas().listen((areas) {
      areasList = areas;
      changeArea(areasList.first);
    });
  }

  getItems() {
    _repo.getItems().listen((items) {
      itemsList = items;
      changeItem(itemsList.first);
    });
  }

  Future<void> saveShop() {
    Map<String, dynamic> shop = {
      "area": _selectedAreaSubject.value,
      "items": shopItemList,
      "name": _nameSubject.value,
      "createdAt": DateTime.now().toIso8601String()
    };

    return _repo.saveShops(parseJsonToShop(shop));
  }

  Future<void> updateShop(String createdAt) {
    Map<String, dynamic> shop = {
      "area": _selectedAreaSubject.value,
      "items": shopItemList,
      "name": _nameSubject.value,
      "createdAt": createdAt
    };

    return _repo.updateShop(shop);
  }

  Future<void> deleteShop(String createdAt) => _repo.deleteShop(createdAt);

  dispose() {
    _shopsSubject.close();
    _selectedAreaSubject.close();
    _selectedItemSubject.close();
    _itemsListSubject.close();
    _nameSubject.close();
  }
}
