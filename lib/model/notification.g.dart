// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppNotifications> _$appNotificationsSerializer =
    new _$AppNotificationsSerializer();

class _$AppNotificationsSerializer
    implements StructuredSerializer<AppNotifications> {
  @override
  final Iterable<Type> types = const [AppNotifications, _$AppNotifications];
  @override
  final String wireName = 'AppNotifications';

  @override
  Iterable<Object> serialize(Serializers serializers, AppNotifications object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'seen',
      serializers.serialize(object.seen,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    if (object.body != null) {
      result
        ..add('body')
        ..add(serializers.serialize(object.body,
            specifiedType: const FullType(String)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.sentDate != null) {
      result
        ..add('sentDate')
        ..add(serializers.serialize(object.sentDate,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AppNotifications deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppNotificationsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'seen':
          result.seen.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sentDate':
          result.sentDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AppNotifications extends AppNotifications {
  @override
  final String body;
  @override
  final BuiltList<String> seen;
  @override
  final String title;
  @override
  final String sentDate;

  factory _$AppNotifications(
          [void Function(AppNotificationsBuilder) updates]) =>
      (new AppNotificationsBuilder()..update(updates)).build();

  _$AppNotifications._({this.body, this.seen, this.title, this.sentDate})
      : super._() {
    if (seen == null) {
      throw new BuiltValueNullFieldError('AppNotifications', 'seen');
    }
  }

  @override
  AppNotifications rebuild(void Function(AppNotificationsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppNotificationsBuilder toBuilder() =>
      new AppNotificationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppNotifications &&
        body == other.body &&
        seen == other.seen &&
        title == other.title &&
        sentDate == other.sentDate;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, body.hashCode), seen.hashCode), title.hashCode),
        sentDate.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppNotifications')
          ..add('body', body)
          ..add('seen', seen)
          ..add('title', title)
          ..add('sentDate', sentDate))
        .toString();
  }
}

class AppNotificationsBuilder
    implements Builder<AppNotifications, AppNotificationsBuilder> {
  _$AppNotifications _$v;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  ListBuilder<String> _seen;
  ListBuilder<String> get seen => _$this._seen ??= new ListBuilder<String>();
  set seen(ListBuilder<String> seen) => _$this._seen = seen;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _sentDate;
  String get sentDate => _$this._sentDate;
  set sentDate(String sentDate) => _$this._sentDate = sentDate;

  AppNotificationsBuilder();

  AppNotificationsBuilder get _$this {
    if (_$v != null) {
      _body = _$v.body;
      _seen = _$v.seen?.toBuilder();
      _title = _$v.title;
      _sentDate = _$v.sentDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppNotifications other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppNotifications;
  }

  @override
  void update(void Function(AppNotificationsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppNotifications build() {
    _$AppNotifications _$result;
    try {
      _$result = _$v ??
          new _$AppNotifications._(
              body: body, seen: seen.build(), title: title, sentDate: sentDate);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'seen';
        seen.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppNotifications', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
