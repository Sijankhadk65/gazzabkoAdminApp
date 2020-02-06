// GENERATED CODE - DO NOT MODIFY BY HAND

part of serializers;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(AppNotifications.serializer)
      ..add(Attendance.serializer)
      ..add(CartItem.serializer)
      ..add(Sales.serializer)
      ..add(SalesPerson.serializer)
      ..add(Shop.serializer)
      ..add(Target.serializer)
      ..add(User.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Attendance)]),
          () => new ListBuilder<Attendance>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CartItem)]),
          () => new ListBuilder<CartItem>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => new ListBuilder<String>()))
    .build();

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
