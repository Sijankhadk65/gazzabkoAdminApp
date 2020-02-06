import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';
import './sales_person.dart';
import './cart_item.dart';
import './shops.dart';

part 'sales.g.dart';

abstract class Sales implements Built<Sales, SalesBuilder> {
  @nullable
  SalesPerson get by;
  @nullable
  BuiltList<CartItem> get items;
  @nullable
  String get deliveryDate;
  @nullable
  Shop get to;

  factory Sales([void Function(SalesBuilder) updates]) = _$Sales;
  Sales._();
  static Serializer<Sales> get serializer => _$salesSerializer;
}

Sales parseJsonToSales(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(Sales.serializer, json);
}
