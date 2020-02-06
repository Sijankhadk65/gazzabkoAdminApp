import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializer.dart';

part 'sales_person.g.dart';

abstract class SalesPerson implements Built<SalesPerson, SalesPersonBuilder> {
  @nullable
  String get name;
  @nullable
  String get type;
  @nullable
  String get area;
  @nullable
  String get email;

  factory SalesPerson([void Function(SalesPersonBuilder) updates]) =
      _$SalesPerson;
  SalesPerson._();
  static Serializer<SalesPerson> get serializer => _$salesPersonSerializer;
}

SalesPerson parseJsonToSalesPerson(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(SalesPerson.serializer, json);
}
