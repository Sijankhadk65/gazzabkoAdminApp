import 'package:gazzabko_admin_app/data/repository.dart';
import 'package:gazzabko_admin_app/model/cart_item.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:rxdart/rxdart.dart';

class AddSalesBloc {
  List<Shop> _shopsList = [];
  List<String> cartItems = [];
  List<CartItem> cartList = [];
  Repository _repository = Repository();

  final _deliveryPointsSubject = BehaviorSubject<List<Shop>>();
  Function(List<Shop>) get changeDeliveryPoints =>
      _deliveryPointsSubject.sink.add;
  Stream<List<Shop>> get deliveryPoints => _deliveryPointsSubject.stream;

  final _deliverypointSubject = BehaviorSubject<String>();
  Function(String) get changeDeliveryPoint => _deliverypointSubject.sink.add;
  Stream<String> get deliveryPoint => _deliverypointSubject.stream;

  final _cartItemsSubject = BehaviorSubject<List<String>>();
  Function(List<String>) get changeCart => _cartItemsSubject.sink.add;
  Stream<List<String>> get cart => _cartItemsSubject.stream;

  final _selectedItemSubject = BehaviorSubject<String>();
  Function(String) get changeItem => _selectedItemSubject.sink.add;
  Stream<String> get item => _selectedItemSubject.stream;

  final _salesItemsSubject = BehaviorSubject<List<CartItem>>();
  Function(List<CartItem>) get changeSalesItems => _salesItemsSubject.sink.add;
  Stream<List<CartItem>> get salesItems => _salesItemsSubject.stream;

  AddSalesBloc();

  setArea(String area) {
    print("the area is set");
  }

  getShops() {
    _repository.getShops().listen((shops) {
      _shopsList = shops;
      changeDeliveryPoints(_shopsList);
    });
  }

  getCartItems() {
    deliveryPoint.listen((pointName) {
      _repository.getCartItems(pointName).listen((items) {
        changeCart(items);
        cartItems = items;
        changeItem(items.first);
      });
    });
  }

  getSalesItem(String timeStamp) => _repository.getSalesItems(timeStamp);

  Future<int> addCartItem() {
    if (cartList
        .map((item) => item.name)
        .toList()
        .contains(_selectedItemSubject.value)) {
      return Future<int>.value(0);
    }
    cartList.add(parseJsonToCartItem(<String, dynamic>{
      "name": "${_selectedItemSubject.value}",
      "quantity": 1
    }));
    changeSalesItems(cartList);
    return Future<int>.value(1);
  }

  Future<int> removeItemFromCart(CartItem item) {
    cartList.remove(item);
    return Future<int>.value(0);
  }

  Future<void> removeSalesItem(CartItem item, String timeStamp) {
    cartList.remove(item);
    return _repository.removeSalesItem(convertToJson(cartList), timeStamp);
  }

  Future<dynamic> addSalesItem(String timeStamp) {
    if (cartList
        .map((item) => item.name)
        .toList()
        .contains(_selectedItemSubject.value)) {
      return Future<int>.value(0);
    }
    cartList.add(parseJsonToCartItem(<String, dynamic>{
      "name": "${_selectedItemSubject.value}",
      "quantity": 1
    }));
    return _repository.addSalesItem(convertToJson(cartList), timeStamp);
  }

  Future<void> saveNewSales({String shopName, String area, User user}) {
    String _timeStamp = DateTime.now().toIso8601String();
    Map<String, dynamic> data = {
      "by": {
        "accType": "${user.accType}",
        "area": "${user.area}",
        "email": "${user.email}",
        "name": "${user.name}"
      },
      "deliveryDate": _timeStamp,
      "items": convertToJson(cartList),
      "to": {"area": "$area", "name": "$shopName"}
    };
    return _repository.saveNewSales(_timeStamp, data);
  }

  void dispose() {
    _deliveryPointsSubject.close();
    _deliverypointSubject.close();
    _cartItemsSubject.close();
    _selectedItemSubject.close();
    _salesItemsSubject.close();
  }
}
