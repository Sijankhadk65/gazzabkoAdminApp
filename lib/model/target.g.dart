// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Target> _$targetSerializer = new _$TargetSerializer();

class _$TargetSerializer implements StructuredSerializer<Target> {
  @override
  final Iterable<Type> types = const [Target, _$Target];
  @override
  final String wireName = 'Target';

  @override
  Iterable<Object> serialize(Serializers serializers, Target object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.area != null) {
      result
        ..add('area')
        ..add(serializers.serialize(object.area,
            specifiedType: const FullType(String)));
    }
    if (object.month != null) {
      result
        ..add('month')
        ..add(serializers.serialize(object.month,
            specifiedType: const FullType(int)));
    }
    if (object.target != null) {
      result
        ..add('target')
        ..add(serializers.serialize(object.target,
            specifiedType: const FullType(int)));
    }
    if (object.year != null) {
      result
        ..add('year')
        ..add(serializers.serialize(object.year,
            specifiedType: const FullType(int)));
    }
    if (object.createdAt != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Target deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TargetBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'area':
          result.area = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'month':
          result.month = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'target':
          result.target = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Target extends Target {
  @override
  final String area;
  @override
  final int month;
  @override
  final int target;
  @override
  final int year;
  @override
  final String createdAt;

  factory _$Target([void Function(TargetBuilder) updates]) =>
      (new TargetBuilder()..update(updates)).build();

  _$Target._({this.area, this.month, this.target, this.year, this.createdAt})
      : super._();

  @override
  Target rebuild(void Function(TargetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TargetBuilder toBuilder() => new TargetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Target &&
        area == other.area &&
        month == other.month &&
        target == other.target &&
        year == other.year &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, area.hashCode), month.hashCode), target.hashCode),
            year.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Target')
          ..add('area', area)
          ..add('month', month)
          ..add('target', target)
          ..add('year', year)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class TargetBuilder implements Builder<Target, TargetBuilder> {
  _$Target _$v;

  String _area;
  String get area => _$this._area;
  set area(String area) => _$this._area = area;

  int _month;
  int get month => _$this._month;
  set month(int month) => _$this._month = month;

  int _target;
  int get target => _$this._target;
  set target(int target) => _$this._target = target;

  int _year;
  int get year => _$this._year;
  set year(int year) => _$this._year = year;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  TargetBuilder();

  TargetBuilder get _$this {
    if (_$v != null) {
      _area = _$v.area;
      _month = _$v.month;
      _target = _$v.target;
      _year = _$v.year;
      _createdAt = _$v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Target other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Target;
  }

  @override
  void update(void Function(TargetBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Target build() {
    final _$result = _$v ??
        new _$Target._(
            area: area,
            month: month,
            target: target,
            year: year,
            createdAt: createdAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
