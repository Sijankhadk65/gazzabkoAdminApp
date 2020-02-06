// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Attendance> _$attendanceSerializer = new _$AttendanceSerializer();

class _$AttendanceSerializer implements StructuredSerializer<Attendance> {
  @override
  final Iterable<Type> types = const [Attendance, _$Attendance];
  @override
  final String wireName = 'Attendance';

  @override
  Iterable<Object> serialize(Serializers serializers, Attendance object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.date != null) {
      result
        ..add('date')
        ..add(serializers.serialize(object.date,
            specifiedType: const FullType(String)));
    }
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Attendance deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AttendanceBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Attendance extends Attendance {
  @override
  final String date;
  @override
  final String status;

  factory _$Attendance([void Function(AttendanceBuilder) updates]) =>
      (new AttendanceBuilder()..update(updates)).build();

  _$Attendance._({this.date, this.status}) : super._();

  @override
  Attendance rebuild(void Function(AttendanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AttendanceBuilder toBuilder() => new AttendanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Attendance && date == other.date && status == other.status;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, date.hashCode), status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Attendance')
          ..add('date', date)
          ..add('status', status))
        .toString();
  }
}

class AttendanceBuilder implements Builder<Attendance, AttendanceBuilder> {
  _$Attendance _$v;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  AttendanceBuilder();

  AttendanceBuilder get _$this {
    if (_$v != null) {
      _date = _$v.date;
      _status = _$v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Attendance other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Attendance;
  }

  @override
  void update(void Function(AttendanceBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Attendance build() {
    final _$result = _$v ?? new _$Attendance._(date: date, status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
