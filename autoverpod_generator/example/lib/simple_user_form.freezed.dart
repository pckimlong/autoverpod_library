// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_user_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SimpleUserState {

 String get firstName; String get lastName; String get email; String get phone; String get company; String get jobTitle; bool get isActive; bool get acceptsMarketing;
/// Create a copy of SimpleUserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleUserStateCopyWith<SimpleUserState> get copyWith => _$SimpleUserStateCopyWithImpl<SimpleUserState>(this as SimpleUserState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleUserState&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.company, company) || other.company == company)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.acceptsMarketing, acceptsMarketing) || other.acceptsMarketing == acceptsMarketing));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,phone,company,jobTitle,isActive,acceptsMarketing);

@override
String toString() {
  return 'SimpleUserState(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, company: $company, jobTitle: $jobTitle, isActive: $isActive, acceptsMarketing: $acceptsMarketing)';
}


}

/// @nodoc
abstract mixin class $SimpleUserStateCopyWith<$Res>  {
  factory $SimpleUserStateCopyWith(SimpleUserState value, $Res Function(SimpleUserState) _then) = _$SimpleUserStateCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String email, String phone, String company, String jobTitle, bool isActive, bool acceptsMarketing
});




}
/// @nodoc
class _$SimpleUserStateCopyWithImpl<$Res>
    implements $SimpleUserStateCopyWith<$Res> {
  _$SimpleUserStateCopyWithImpl(this._self, this._then);

  final SimpleUserState _self;
  final $Res Function(SimpleUserState) _then;

/// Create a copy of SimpleUserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? company = null,Object? jobTitle = null,Object? isActive = null,Object? acceptsMarketing = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,acceptsMarketing: null == acceptsMarketing ? _self.acceptsMarketing : acceptsMarketing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SimpleUserState].
extension SimpleUserStatePatterns on SimpleUserState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimpleUserState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimpleUserState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimpleUserState value)  $default,){
final _that = this;
switch (_that) {
case _SimpleUserState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimpleUserState value)?  $default,){
final _that = this;
switch (_that) {
case _SimpleUserState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String phone,  String company,  String jobTitle,  bool isActive,  bool acceptsMarketing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimpleUserState() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.phone,_that.company,_that.jobTitle,_that.isActive,_that.acceptsMarketing);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String email,  String phone,  String company,  String jobTitle,  bool isActive,  bool acceptsMarketing)  $default,) {final _that = this;
switch (_that) {
case _SimpleUserState():
return $default(_that.firstName,_that.lastName,_that.email,_that.phone,_that.company,_that.jobTitle,_that.isActive,_that.acceptsMarketing);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String email,  String phone,  String company,  String jobTitle,  bool isActive,  bool acceptsMarketing)?  $default,) {final _that = this;
switch (_that) {
case _SimpleUserState() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.phone,_that.company,_that.jobTitle,_that.isActive,_that.acceptsMarketing);case _:
  return null;

}
}

}

/// @nodoc


class _SimpleUserState extends SimpleUserState {
  const _SimpleUserState({this.firstName = '', this.lastName = '', this.email = '', this.phone = '', this.company = '', this.jobTitle = '', this.isActive = false, this.acceptsMarketing = false}): super._();
  

@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String company;
@override@JsonKey() final  String jobTitle;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool acceptsMarketing;

/// Create a copy of SimpleUserState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimpleUserStateCopyWith<_SimpleUserState> get copyWith => __$SimpleUserStateCopyWithImpl<_SimpleUserState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimpleUserState&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.company, company) || other.company == company)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.acceptsMarketing, acceptsMarketing) || other.acceptsMarketing == acceptsMarketing));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,phone,company,jobTitle,isActive,acceptsMarketing);

@override
String toString() {
  return 'SimpleUserState(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, company: $company, jobTitle: $jobTitle, isActive: $isActive, acceptsMarketing: $acceptsMarketing)';
}


}

/// @nodoc
abstract mixin class _$SimpleUserStateCopyWith<$Res> implements $SimpleUserStateCopyWith<$Res> {
  factory _$SimpleUserStateCopyWith(_SimpleUserState value, $Res Function(_SimpleUserState) _then) = __$SimpleUserStateCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String email, String phone, String company, String jobTitle, bool isActive, bool acceptsMarketing
});




}
/// @nodoc
class __$SimpleUserStateCopyWithImpl<$Res>
    implements _$SimpleUserStateCopyWith<$Res> {
  __$SimpleUserStateCopyWithImpl(this._self, this._then);

  final _SimpleUserState _self;
  final $Res Function(_SimpleUserState) _then;

/// Create a copy of SimpleUserState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? company = null,Object? jobTitle = null,Object? isActive = null,Object? acceptsMarketing = null,}) {
  return _then(_SimpleUserState(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,acceptsMarketing: null == acceptsMarketing ? _self.acceptsMarketing : acceptsMarketing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
