library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:gazzabko_admin_app/model/attendance.dart';
import 'package:gazzabko_admin_app/model/cart_item.dart';
import 'package:gazzabko_admin_app/model/notification.dart';
import 'package:gazzabko_admin_app/model/sales.dart';
import 'package:gazzabko_admin_app/model/sales_person.dart';
import 'package:gazzabko_admin_app/model/shops.dart';
import 'package:gazzabko_admin_app/model/target.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:built_collection/built_collection.dart';

part 'serializer.g.dart';

@SerializersFor(const [
  User,
  Attendance,
  CartItem,
  AppNotifications,
  SalesPerson,
  Sales,
  Shop,
  Target,
  User
])
final Serializers serializers = _$serializers;
final jsonSerializer =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
