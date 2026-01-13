// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppSettings {
  /// Theme mode (light, dark, system)
  @HiveField(0)
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  /// Accent color index
  @HiveField(1)
  int get accentColorIndex => throw _privateConstructorUsedError;

  /// Audio quality (low, medium, high)
  @HiveField(2)
  AudioQuality get audioQuality => throw _privateConstructorUsedError;

  /// Crossfade duration in seconds (0 = disabled)
  @HiveField(3)
  int get crossfadeDuration => throw _privateConstructorUsedError;

  /// Auto-refresh library on app start
  @HiveField(4)
  bool get autoRefreshOnStart => throw _privateConstructorUsedError;

  /// Music folders for library scanning
  @HiveField(5)
  List<String> get musicFolders => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {@HiveField(0) ThemeMode themeMode,
      @HiveField(1) int accentColorIndex,
      @HiveField(2) AudioQuality audioQuality,
      @HiveField(3) int crossfadeDuration,
      @HiveField(4) bool autoRefreshOnStart,
      @HiveField(5) List<String> musicFolders});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? accentColorIndex = null,
    Object? audioQuality = null,
    Object? crossfadeDuration = null,
    Object? autoRefreshOnStart = null,
    Object? musicFolders = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      accentColorIndex: null == accentColorIndex
          ? _value.accentColorIndex
          : accentColorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      audioQuality: null == audioQuality
          ? _value.audioQuality
          : audioQuality // ignore: cast_nullable_to_non_nullable
              as AudioQuality,
      crossfadeDuration: null == crossfadeDuration
          ? _value.crossfadeDuration
          : crossfadeDuration // ignore: cast_nullable_to_non_nullable
              as int,
      autoRefreshOnStart: null == autoRefreshOnStart
          ? _value.autoRefreshOnStart
          : autoRefreshOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      musicFolders: null == musicFolders
          ? _value.musicFolders
          : musicFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) ThemeMode themeMode,
      @HiveField(1) int accentColorIndex,
      @HiveField(2) AudioQuality audioQuality,
      @HiveField(3) int crossfadeDuration,
      @HiveField(4) bool autoRefreshOnStart,
      @HiveField(5) List<String> musicFolders});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? accentColorIndex = null,
    Object? audioQuality = null,
    Object? crossfadeDuration = null,
    Object? autoRefreshOnStart = null,
    Object? musicFolders = null,
  }) {
    return _then(_$AppSettingsImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      accentColorIndex: null == accentColorIndex
          ? _value.accentColorIndex
          : accentColorIndex // ignore: cast_nullable_to_non_nullable
              as int,
      audioQuality: null == audioQuality
          ? _value.audioQuality
          : audioQuality // ignore: cast_nullable_to_non_nullable
              as AudioQuality,
      crossfadeDuration: null == crossfadeDuration
          ? _value.crossfadeDuration
          : crossfadeDuration // ignore: cast_nullable_to_non_nullable
              as int,
      autoRefreshOnStart: null == autoRefreshOnStart
          ? _value.autoRefreshOnStart
          : autoRefreshOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      musicFolders: null == musicFolders
          ? _value._musicFolders
          : musicFolders // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$AppSettingsImpl extends _AppSettings {
  const _$AppSettingsImpl(
      {@HiveField(0) this.themeMode = ThemeMode.system,
      @HiveField(1) this.accentColorIndex = 0,
      @HiveField(2) this.audioQuality = AudioQuality.high,
      @HiveField(3) this.crossfadeDuration = 0,
      @HiveField(4) this.autoRefreshOnStart = true,
      @HiveField(5) final List<String> musicFolders = const []})
      : _musicFolders = musicFolders,
        super._();

  /// Theme mode (light, dark, system)
  @override
  @JsonKey()
  @HiveField(0)
  final ThemeMode themeMode;

  /// Accent color index
  @override
  @JsonKey()
  @HiveField(1)
  final int accentColorIndex;

  /// Audio quality (low, medium, high)
  @override
  @JsonKey()
  @HiveField(2)
  final AudioQuality audioQuality;

  /// Crossfade duration in seconds (0 = disabled)
  @override
  @JsonKey()
  @HiveField(3)
  final int crossfadeDuration;

  /// Auto-refresh library on app start
  @override
  @JsonKey()
  @HiveField(4)
  final bool autoRefreshOnStart;

  /// Music folders for library scanning
  final List<String> _musicFolders;

  /// Music folders for library scanning
  @override
  @JsonKey()
  @HiveField(5)
  List<String> get musicFolders {
    if (_musicFolders is EqualUnmodifiableListView) return _musicFolders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_musicFolders);
  }

  @override
  String toString() {
    return 'AppSettings(themeMode: $themeMode, accentColorIndex: $accentColorIndex, audioQuality: $audioQuality, crossfadeDuration: $crossfadeDuration, autoRefreshOnStart: $autoRefreshOnStart, musicFolders: $musicFolders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.accentColorIndex, accentColorIndex) ||
                other.accentColorIndex == accentColorIndex) &&
            (identical(other.audioQuality, audioQuality) ||
                other.audioQuality == audioQuality) &&
            (identical(other.crossfadeDuration, crossfadeDuration) ||
                other.crossfadeDuration == crossfadeDuration) &&
            (identical(other.autoRefreshOnStart, autoRefreshOnStart) ||
                other.autoRefreshOnStart == autoRefreshOnStart) &&
            const DeepCollectionEquality()
                .equals(other._musicFolders, _musicFolders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeMode,
      accentColorIndex,
      audioQuality,
      crossfadeDuration,
      autoRefreshOnStart,
      const DeepCollectionEquality().hash(_musicFolders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);
}

abstract class _AppSettings extends AppSettings {
  const factory _AppSettings(
      {@HiveField(0) final ThemeMode themeMode,
      @HiveField(1) final int accentColorIndex,
      @HiveField(2) final AudioQuality audioQuality,
      @HiveField(3) final int crossfadeDuration,
      @HiveField(4) final bool autoRefreshOnStart,
      @HiveField(5) final List<String> musicFolders}) = _$AppSettingsImpl;
  const _AppSettings._() : super._();

  @override

  /// Theme mode (light, dark, system)
  @HiveField(0)
  ThemeMode get themeMode;
  @override

  /// Accent color index
  @HiveField(1)
  int get accentColorIndex;
  @override

  /// Audio quality (low, medium, high)
  @HiveField(2)
  AudioQuality get audioQuality;
  @override

  /// Crossfade duration in seconds (0 = disabled)
  @HiveField(3)
  int get crossfadeDuration;
  @override

  /// Auto-refresh library on app start
  @HiveField(4)
  bool get autoRefreshOnStart;
  @override

  /// Music folders for library scanning
  @HiveField(5)
  List<String> get musicFolders;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
