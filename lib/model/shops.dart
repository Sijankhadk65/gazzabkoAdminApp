import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'shops.g.dart';

abstract class Shop implements Built<Shop, ShopBuilder> {
  @nullable
  String get name;
  @nullable
  String get area;
  @nullable
  String get createdAt;
  BuiltList<String> get items;

  factory Shop([void Function(ShopBuilder) updates]) = _$Shop;
  Shop._();
  static Serializer<Shop> get serializer => _$shopSerializer;
}

Shop parseJsonToShop(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(Shop.serializer, json);
}

Map<String, dynamic> convertShopToJson(Shop shop) {
  return {
    "name": shop.name,
    "area": shop.area,
    "items": shop.items.asList(),
    "createdAt": shop.createdAt
  };
}
