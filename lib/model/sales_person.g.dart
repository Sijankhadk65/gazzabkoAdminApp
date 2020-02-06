// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_person.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SalesPerson> _$salesPersonSerializer = new _$SalesPersonSerializer();

class _$SalesPersonSerializer implements StructuredSerializer<SalesPerson> {
  @override
  final Iterable<Type> types = const [SalesPerson, _$SalesPerson];
  @override
  final String wireName = 'SalesPerson';

  @override
  Iterable<Object> serialize(Serializers serializers, SalesPerson object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(String)));
    }
    if (object.area != null) {
      result
        ..add('area')
        ..add(serializers.serialize(object.area,
            specifiedType: const FullType(String)));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SalesPerson deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SalesPersonBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'area':
          result.area = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SalesPerson extends SalesPerson {
  @override
  final String name;
  @override
  final String type;
  @override
  final String area;
  @override
  final String email;

  factory _$SalesPerson([void Function(SalesPersonBuilder) updates]) =>
      (new SalesPersonBuilder()..update(updates)).build();

  _$SalesPerson._({this.name, this.type, this.area, this.email}) : super._();

  @override
  SalesPerson rebuild(void Function(SalesPersonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SalesPersonBuilder toBuilder() => new SalesPersonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SalesPerson &&
        name == other.name &&
        type == other.type &&
        area == other.area &&
        email == other.email;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), type.hashCode), area.hashCode),
        email.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SalesPerson')
          ..add('name', name)
          ..add('type', type)
          ..add('area', area)
          ..add('email', email))
        .toString();
  }
}

class SalesPersonBuilder implements Builder<SalesPerson, SalesPersonBuilder> {
  _$SalesPerson _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  String _area;
  String get area => _$this._area;
  set area(String area) => _$this._area = area;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  SalesPersonBuilder();

  SalesPersonBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _type = _$v.type;
      _area = _$v.area;
      _email = _$v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SalesPerson other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SalesPerson;
  }

  @override
  void update(void Function(SalesPersonBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SalesPerson build() {
    final _$result = _$v ??
        new _$SalesPerson._(name: name, type: type, area: area, email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
