import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gazzabko_admin_app/model/serializer.dart';

part 'target.g.dart';

abstract class Target implements Built<Target, TargetBuilder> {
  @nullable
  String get area;
  @nullable
  int get month;
  @nullable
  int get target;
  @nullable
  int get year;
  @nullable
  String get createdAt;
  factory Target([void Function(TargetBuilder) updates]) = _$Target;
  Target._();
  static Serializer<Target> get serializer => _$targetSerializer;
}

Target parseJsonToTarget(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(Target.serializer, json);
}

Map<String, dynamic> convertTargetToJson(Target target) {
  return {
    "area": target.area,
    "month": target.month,
    "target": target.target,
    "year": target.year,
    "createdAt": target.createdAt
  };
}
