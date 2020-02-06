// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shops.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Shop> _$shopSerializer = new _$ShopSerializer();

class _$ShopSerializer implements StructuredSerializer<Shop> {
  @override
  final Iterable<Type> types = const [Shop, _$Shop];
  @override
  final String wireName = 'Shop';

  @override
  Iterable<Object> serialize(Serializers serializers, Shop object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'items',
      serializers.serialize(object.items,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.area != null) {
      result
        ..add('area')
        ..add(serializers.serialize(object.area,
            specifiedType: const FullType(String)));
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
  Shop deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ShopBuilder();

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
        case 'area':
          result.area = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$Shop extends Shop {
  @override
  final String name;
  @override
  final String area;
  @override
  final String createdAt;
  @override
  final BuiltList<String> items;

  factory _$Shop([void Function(ShopBuilder) updates]) =>
      (new ShopBuilder()..update(updates)).build();

  _$Shop._({this.name, this.area, this.createdAt, this.items}) : super._() {
    if (items == null) {
      throw new BuiltValueNullFieldError('Shop', 'items');
    }
  }

  @override
  Shop rebuild(void Function(ShopBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopBuilder toBuilder() => new ShopBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Shop &&
        name == other.name &&
        area == other.area &&
        createdAt == other.createdAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), area.hashCode), createdAt.hashCode),
        items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Shop')
          ..add('name', name)
          ..add('area', area)
          ..add('createdAt', createdAt)
          ..add('items', items))
        .toString();
  }
}

class ShopBuilder implements Builder<Shop, ShopBuilder> {
  _$Shop _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _area;
  String get area => _$this._area;
  set area(String area) => _$this._area = area;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  ListBuilder<String> _items;
  ListBuilder<String> get items => _$this._items ??= new ListBuilder<String>();
  set items(ListBuilder<String> items) => _$this._items = items;

  ShopBuilder();

  ShopBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _area = _$v.area;
      _createdAt = _$v.createdAt;
      _items = _$v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Shop other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Shop;
  }

  @override
  void update(void Function(ShopBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Shop build() {
    _$Shop _$result;
    try {
      _$result = _$v ??
          new _$Shop._(
              name: name,
              area: area,
              createdAt: createdAt,
              items: items.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Shop', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
