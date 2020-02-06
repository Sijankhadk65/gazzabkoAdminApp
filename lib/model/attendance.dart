import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'attendance.g.dart';

abstract class Attendance implements Built<Attendance, AttendanceBuilder> {
  @nullable
  String get date;
  @nullable
  String get status;

  factory Attendance([void Function(AttendanceBuilder) updates]) = _$Attendance;
  Attendance._();
  static Serializer<Attendance> get serializer => _$attendanceSerializer;
}
