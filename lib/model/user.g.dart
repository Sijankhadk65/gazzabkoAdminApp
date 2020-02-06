// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.accType != null) {
      result
        ..add('accType')
        ..add(serializers.serialize(object.accType,
            specifiedType: const FullType(String)));
    }
    if (object.admin != null) {
      result
        ..add('admin')
        ..add(serializers.serialize(object.admin,
            specifiedType: const FullType(String)));
    }
    if (object.area != null) {
      result
        ..add('area')
        ..add(serializers.serialize(object.area,
            specifiedType: const FullType(String)));
    }
    if (object.attendance != null) {
      result
        ..add('attendance')
        ..add(serializers.serialize(object.attendance,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Attendance)])));
    }
    if (object.email != null) {
      result
        ..add('email')
        ..add(serializers.serialize(object.email,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.photoUrl != null) {
      result
        ..add('photoUrl')
        ..add(serializers.serialize(object.photoUrl,
            specifiedType: const FullType(String)));
    }
    if (object.password != null) {
      result
        ..add('password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'accType':
          result.accType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'admin':
          result.admin = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'area':
          result.area = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'attendance':
          result.attendance.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Attendance)]))
              as BuiltList<dynamic>);
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photoUrl':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final String accType;
  @override
  final String admin;
  @override
  final String area;
  @override
  final BuiltList<Attendance> attendance;
  @override
  final String email;
  @override
  final String name;
  @override
  final String photoUrl;
  @override
  final String password;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.accType,
      this.admin,
      this.area,
      this.attendance,
      this.email,
      this.name,
      this.photoUrl,
      this.password})
      : super._();

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        accType == other.accType &&
        admin == other.admin &&
        area == other.area &&
        attendance == other.attendance &&
        email == other.email &&
        name == other.name &&
        photoUrl == other.photoUrl &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, accType.hashCode), admin.hashCode),
                            area.hashCode),
                        attendance.hashCode),
                    email.hashCode),
                name.hashCode),
            photoUrl.hashCode),
        password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('accType', accType)
          ..add('admin', admin)
          ..add('area', area)
          ..add('attendance', attendance)
          ..add('email', email)
          ..add('name', name)
          ..add('photoUrl', photoUrl)
          ..add('password', password))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _accType;
  String get accType => _$this._accType;
  set accType(String accType) => _$this._accType = accType;

  String _admin;
  String get admin => _$this._admin;
  set admin(String admin) => _$this._admin = admin;

  String _area;
  String get area => _$this._area;
  set area(String area) => _$this._area = area;

  ListBuilder<Attendance> _attendance;
  ListBuilder<Attendance> get attendance =>
      _$this._attendance ??= new ListBuilder<Attendance>();
  set attendance(ListBuilder<Attendance> attendance) =>
      _$this._attendance = attendance;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _photoUrl;
  String get photoUrl => _$this._photoUrl;
  set photoUrl(String photoUrl) => _$this._photoUrl = photoUrl;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _accType = _$v.accType;
      _admin = _$v.admin;
      _area = _$v.area;
      _attendance = _$v.attendance?.toBuilder();
      _email = _$v.email;
      _name = _$v.name;
      _photoUrl = _$v.photoUrl;
      _password = _$v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              accType: accType,
              admin: admin,
              area: area,
              attendance: _attendance?.build(),
              email: email,
              name: name,
              photoUrl: photoUrl,
              password: password);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'attendance';
        _attendance?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
