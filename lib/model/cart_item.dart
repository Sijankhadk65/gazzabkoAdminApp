import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'cart_item.g.dart';

abstract class CartItem implements Built<CartItem, CartItemBuilder> {
  @nullable
  String get name;
  @nullable
  int get quantity;

  factory CartItem([void Function(CartItemBuilder) updates]) = _$CartItem;
  CartItem._();
  static Serializer<CartItem> get serializer => _$cartItemSerializer;
}

CartItem parseJsonToCartItem(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(CartItem.serializer, json);
}

List<Map<String, dynamic>> convertToJson(List<CartItem> items) {
  return items
      .map((item) => {"name": item.name, "quantity": item.quantity})
      .toList();
}
