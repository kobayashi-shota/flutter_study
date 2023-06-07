// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TodoItem {
  String get title => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoItemCopyWith<TodoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoItemCopyWith<$Res> {
  factory $TodoItemCopyWith(TodoItem value, $Res Function(TodoItem) then) =
      _$TodoItemCopyWithImpl<$Res, TodoItem>;
  @useResult
  $Res call({String title, bool completed});
}

/// @nodoc
class _$TodoItemCopyWithImpl<$Res, $Val extends TodoItem>
    implements $TodoItemCopyWith<$Res> {
  _$TodoItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TodoItemCopyWith<$Res> implements $TodoItemCopyWith<$Res> {
  factory _$$_TodoItemCopyWith(
          _$_TodoItem value, $Res Function(_$_TodoItem) then) =
      __$$_TodoItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, bool completed});
}

/// @nodoc
class __$$_TodoItemCopyWithImpl<$Res>
    extends _$TodoItemCopyWithImpl<$Res, _$_TodoItem>
    implements _$$_TodoItemCopyWith<$Res> {
  __$$_TodoItemCopyWithImpl(
      _$_TodoItem _value, $Res Function(_$_TodoItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? completed = null,
  }) {
    return _then(_$_TodoItem(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TodoItem implements _TodoItem {
  const _$_TodoItem({required this.title, required this.completed});

  @override
  final String title;
  @override
  final bool completed;

  @override
  String toString() {
    return 'TodoItem(title: $title, completed: $completed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoItem &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, completed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoItemCopyWith<_$_TodoItem> get copyWith =>
      __$$_TodoItemCopyWithImpl<_$_TodoItem>(this, _$identity);
}

abstract class _TodoItem implements TodoItem {
  const factory _TodoItem(
      {required final String title,
      required final bool completed}) = _$_TodoItem;

  @override
  String get title;
  @override
  bool get completed;
  @override
  @JsonKey(ignore: true)
  _$$_TodoItemCopyWith<_$_TodoItem> get copyWith =>
      throw _privateConstructorUsedError;
}
