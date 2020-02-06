// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Sales> _$salesSerializer = new _$SalesSerializer();

class _$SalesSerializer implements StructuredSerializer<Sales> {
  @override
  final Iterable<Type> types = const [Sales, _$Sales];
  @override
  final String wireName = 'Sales';

  @override
  Iterable<Object> serialize(Serializers serializers, Sales object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.by != null) {
      result
        ..add('by')
        ..add(serializers.serialize(object.by,
            specifiedType: const FullType(SalesPerson)));
    }
    if (object.items != null) {
      result
        ..add('items')
        ..add(serializers.serialize(object.items,
            specifiedType:
                const FullType(BuiltList, const [const FullType(CartItem)])));
    }
    if (object.deliveryDate != null) {
      result
        ..add('deliveryDate')
        ..add(serializers.serialize(object.deliveryDate,
            specifiedType: const FullType(String)));
    }
    if (object.to != null) {
      result
        ..add('to')
        ..add(serializers.serialize(object.to,
            specifiedType: const FullType(Shop)));
    }
    return result;
  }

  @override
  Sales deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SalesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'by':
          result.by.replace(serializers.deserialize(value,
              specifiedType: const FullType(SalesPerson)) as SalesPerson);
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CartItem)]))
              as BuiltList<dynamic>);
          break;
        case 'deliveryDate':
          result.deliveryDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'to':
          result.to.replace(serializers.deserialize(value,
              specifiedType: const FullType(Shop)) as Shop);
          break;
      }
    }

    return result.build();
  }
}

class _$Sales extends Sales {
  @override
  final SalesPerson by;
  @override
  final BuiltList<CartItem> items;
  @override
  final String deliveryDate;
  @override
  final Shop to;

  factory _$Sales([void Function(SalesBuilder) updates]) =>
      (new SalesBuilder()..update(updates)).build();

  _$Sales._({this.by, this.items, this.deliveryDate, this.to}) : super._();

  @override
  Sales rebuild(void Function(SalesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SalesBuilder toBuilder() => new SalesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sales &&
        by == other.by &&
        items == other.items &&
        deliveryDate == other.deliveryDate &&
        to == other.to;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, by.hashCode), items.hashCode), deliveryDate.hashCode),
        to.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Sales')
          ..add('by', by)
          ..add('items', items)
          ..add('deliveryDate', deliveryDate)
          ..add('to', to))
        .toString();
  }
}

class SalesBuilder implements Builder<Sales, SalesBuilder> {
  _$Sales _$v;

  SalesPersonBuilder _by;
  SalesPersonBuilder get by => _$this._by ??= new SalesPersonBuilder();
  set by(SalesPersonBuilder by) => _$this._by = by;

  ListBuilder<CartItem> _items;
  ListBuilder<CartItem> get items =>
      _$this._items ??= new ListBuilder<CartItem>();
  set items(ListBuilder<CartItem> items) => _$this._items = items;

  String _deliveryDate;
  String get deliveryDate => _$this._deliveryDate;
  set deliveryDate(String deliveryDate) => _$this._deliveryDate = deliveryDate;

  ShopBuilder _to;
  ShopBuilder get to => _$this._to ??= new ShopBuilder();
  set to(ShopBuilder to) => _$this._to = to;

  SalesBuilder();

  SalesBuilder get _$this {
    if (_$v != null) {
      _by = _$v.by?.toBuilder();
      _items = _$v.items?.toBuilder();
      _deliveryDate = _$v.deliveryDate;
      _to = _$v.to?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Sales other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Sales;
  }

  @override
  void update(void Function(SalesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Sales build() {
    _$Sales _$result;
    try {
      _$result = _$v ??
          new _$Sales._(
              by: _by?.build(),
              items: _items?.build(),
              deliveryDate: deliveryDate,
              to: _to?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'by';
        _by?.build();
        _$failedField = 'items';
        _items?.build();

        _$failedField = 'to';
        _to?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Sales', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
