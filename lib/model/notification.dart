import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:gazzabko_admin_app/model/serializer.dart';

part 'notification.g.dart';

abstract class AppNotifications
    implements Built<AppNotifications, AppNotificationsBuilder> {
  @nullable
  String get body;
  BuiltList<String> get seen;
  @nullable
  String get title;
  @nullable
  String get sentDate;
  factory AppNotifications([void Function(AppNotificationsBuilder) updates]) =
      _$AppNotifications;
  AppNotifications._();
  static Serializer<AppNotifications> get serializer =>
      _$appNotificationsSerializer;
}

AppNotifications parseJsonToNotification(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(AppNotifications.serializer, json);
}

Map<String, dynamic> convertAppNotificationToJson(
    AppNotifications notification) {
  return {
    "body": notification.body,
    "title": notification.title,
    "seen": notification.seen.toList(),
    "sentDate": notification.sentDate
  };
}
