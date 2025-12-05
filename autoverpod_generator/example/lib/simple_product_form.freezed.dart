// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_product_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SimpleProductState {

 String get name; String get description; double get price; String get category; String get sku; int get stockQuantity; bool get isActive; bool get isFeatured; List<String> get tags;
/// Create a copy of SimpleProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleProductStateCopyWith<SimpleProductState> get copyWith => _$SimpleProductStateCopyWithImpl<SimpleProductState>(this as SimpleProductState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleProductState&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,price,category,sku,stockQuantity,isActive,isFeatured,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'SimpleProductState(name: $name, description: $description, price: $price, category: $category, sku: $sku, stockQuantity: $stockQuantity, isActive: $isActive, isFeatured: $isFeatured, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $SimpleProductStateCopyWith<$Res>  {
  factory $SimpleProductStateCopyWith(SimpleProductState value, $Res Function(SimpleProductState) _then) = _$SimpleProductStateCopyWithImpl;
@useResult
$Res call({
 String name, String description, double price, String category, String sku, int stockQuantity, bool isActive, bool isFeatured, List<String> tags
});




}
/// @nodoc
class _$SimpleProductStateCopyWithImpl<$Res>
    implements $SimpleProductStateCopyWith<$Res> {
  _$SimpleProductStateCopyWithImpl(this._self, this._then);

  final SimpleProductState _self;
  final $Res Function(SimpleProductState) _then;

/// Create a copy of SimpleProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? price = null,Object? category = null,Object? sku = null,Object? stockQuantity = null,Object? isActive = null,Object? isFeatured = null,Object? tags = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SimpleProductState].
extension SimpleProductStatePatterns on SimpleProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimpleProductState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimpleProductState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimpleProductState value)  $default,){
final _that = this;
switch (_that) {
case _SimpleProductState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimpleProductState value)?  $default,){
final _that = this;
switch (_that) {
case _SimpleProductState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  double price,  String category,  String sku,  int stockQuantity,  bool isActive,  bool isFeatured,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimpleProductState() when $default != null:
return $default(_that.name,_that.description,_that.price,_that.category,_that.sku,_that.stockQuantity,_that.isActive,_that.isFeatured,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  double price,  String category,  String sku,  int stockQuantity,  bool isActive,  bool isFeatured,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _SimpleProductState():
return $default(_that.name,_that.description,_that.price,_that.category,_that.sku,_that.stockQuantity,_that.isActive,_that.isFeatured,_that.tags);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  double price,  String category,  String sku,  int stockQuantity,  bool isActive,  bool isFeatured,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _SimpleProductState() when $default != null:
return $default(_that.name,_that.description,_that.price,_that.category,_that.sku,_that.stockQuantity,_that.isActive,_that.isFeatured,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _SimpleProductState extends SimpleProductState {
  const _SimpleProductState({this.name = '', this.description = '', this.price = 0.0, this.category = '', this.sku = '', this.stockQuantity = 0, this.isActive = false, this.isFeatured = false, final  List<String> tags = const []}): _tags = tags,super._();
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String description;
@override@JsonKey() final  double price;
@override@JsonKey() final  String category;
@override@JsonKey() final  String sku;
@override@JsonKey() final  int stockQuantity;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isFeatured;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of SimpleProductState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimpleProductStateCopyWith<_SimpleProductState> get copyWith => __$SimpleProductStateCopyWithImpl<_SimpleProductState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimpleProductState&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.category, category) || other.category == category)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,price,category,sku,stockQuantity,isActive,isFeatured,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'SimpleProductState(name: $name, description: $description, price: $price, category: $category, sku: $sku, stockQuantity: $stockQuantity, isActive: $isActive, isFeatured: $isFeatured, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$SimpleProductStateCopyWith<$Res> implements $SimpleProductStateCopyWith<$Res> {
  factory _$SimpleProductStateCopyWith(_SimpleProductState value, $Res Function(_SimpleProductState) _then) = __$SimpleProductStateCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, double price, String category, String sku, int stockQuantity, bool isActive, bool isFeatured, List<String> tags
});




}
/// @nodoc
class __$SimpleProductStateCopyWithImpl<$Res>
    implements _$SimpleProductStateCopyWith<$Res> {
  __$SimpleProductStateCopyWithImpl(this._self, this._then);

  final _SimpleProductState _self;
  final $Res Function(_SimpleProductState) _then;

/// Create a copy of SimpleProductState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? price = null,Object? category = null,Object? sku = null,Object? stockQuantity = null,Object? isActive = null,Object? isFeatured = null,Object? tags = null,}) {
  return _then(_SimpleProductState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
