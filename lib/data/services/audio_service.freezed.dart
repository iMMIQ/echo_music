// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlaybackState {
  bool get isPlaying => throw _privateConstructorUsedError;
  Song? get currentSong => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  double get playbackSpeed => throw _privateConstructorUsedError;
  List<Song> get queue => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  RepeatMode get repeatMode => throw _privateConstructorUsedError;
  bool get isShuffle => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlaybackStateCopyWith<PlaybackState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackStateCopyWith<$Res> {
  factory $PlaybackStateCopyWith(
          PlaybackState value, $Res Function(PlaybackState) then) =
      _$PlaybackStateCopyWithImpl<$Res, PlaybackState>;
  @useResult
  $Res call(
      {bool isPlaying,
      Song? currentSong,
      Duration position,
      Duration duration,
      double playbackSpeed,
      List<Song> queue,
      int currentIndex,
      RepeatMode repeatMode,
      bool isShuffle});

  $SongCopyWith<$Res>? get currentSong;
}

/// @nodoc
class _$PlaybackStateCopyWithImpl<$Res, $Val extends PlaybackState>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? currentSong = freezed,
    Object? position = null,
    Object? duration = null,
    Object? playbackSpeed = null,
    Object? queue = null,
    Object? currentIndex = null,
    Object? repeatMode = null,
    Object? isShuffle = null,
  }) {
    return _then(_value.copyWith(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      currentSong: freezed == currentSong
          ? _value.currentSong
          : currentSong // ignore: cast_nullable_to_non_nullable
              as Song?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      playbackSpeed: null == playbackSpeed
          ? _value.playbackSpeed
          : playbackSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      queue: null == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      repeatMode: null == repeatMode
          ? _value.repeatMode
          : repeatMode // ignore: cast_nullable_to_non_nullable
              as RepeatMode,
      isShuffle: null == isShuffle
          ? _value.isShuffle
          : isShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SongCopyWith<$Res>? get currentSong {
    if (_value.currentSong == null) {
      return null;
    }

    return $SongCopyWith<$Res>(_value.currentSong!, (value) {
      return _then(_value.copyWith(currentSong: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlaybackStateImplCopyWith<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  factory _$$PlaybackStateImplCopyWith(
          _$PlaybackStateImpl value, $Res Function(_$PlaybackStateImpl) then) =
      __$$PlaybackStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isPlaying,
      Song? currentSong,
      Duration position,
      Duration duration,
      double playbackSpeed,
      List<Song> queue,
      int currentIndex,
      RepeatMode repeatMode,
      bool isShuffle});

  @override
  $SongCopyWith<$Res>? get currentSong;
}

/// @nodoc
class __$$PlaybackStateImplCopyWithImpl<$Res>
    extends _$PlaybackStateCopyWithImpl<$Res, _$PlaybackStateImpl>
    implements _$$PlaybackStateImplCopyWith<$Res> {
  __$$PlaybackStateImplCopyWithImpl(
      _$PlaybackStateImpl _value, $Res Function(_$PlaybackStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
    Object? currentSong = freezed,
    Object? position = null,
    Object? duration = null,
    Object? playbackSpeed = null,
    Object? queue = null,
    Object? currentIndex = null,
    Object? repeatMode = null,
    Object? isShuffle = null,
  }) {
    return _then(_$PlaybackStateImpl(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      currentSong: freezed == currentSong
          ? _value.currentSong
          : currentSong // ignore: cast_nullable_to_non_nullable
              as Song?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      playbackSpeed: null == playbackSpeed
          ? _value.playbackSpeed
          : playbackSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      queue: null == queue
          ? _value._queue
          : queue // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      repeatMode: null == repeatMode
          ? _value.repeatMode
          : repeatMode // ignore: cast_nullable_to_non_nullable
              as RepeatMode,
      isShuffle: null == isShuffle
          ? _value.isShuffle
          : isShuffle // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PlaybackStateImpl implements _PlaybackState {
  const _$PlaybackStateImpl(
      {required this.isPlaying,
      required this.currentSong,
      required this.position,
      required this.duration,
      required this.playbackSpeed,
      required final List<Song> queue,
      required this.currentIndex,
      this.repeatMode = RepeatMode.off,
      this.isShuffle = false})
      : _queue = queue;

  @override
  final bool isPlaying;
  @override
  final Song? currentSong;
  @override
  final Duration position;
  @override
  final Duration duration;
  @override
  final double playbackSpeed;
  final List<Song> _queue;
  @override
  List<Song> get queue {
    if (_queue is EqualUnmodifiableListView) return _queue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queue);
  }

  @override
  final int currentIndex;
  @override
  @JsonKey()
  final RepeatMode repeatMode;
  @override
  @JsonKey()
  final bool isShuffle;

  @override
  String toString() {
    return 'PlaybackState(isPlaying: $isPlaying, currentSong: $currentSong, position: $position, duration: $duration, playbackSpeed: $playbackSpeed, queue: $queue, currentIndex: $currentIndex, repeatMode: $repeatMode, isShuffle: $isShuffle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaybackStateImpl &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.currentSong, currentSong) ||
                other.currentSong == currentSong) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.playbackSpeed, playbackSpeed) ||
                other.playbackSpeed == playbackSpeed) &&
            const DeepCollectionEquality().equals(other._queue, _queue) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.repeatMode, repeatMode) ||
                other.repeatMode == repeatMode) &&
            (identical(other.isShuffle, isShuffle) ||
                other.isShuffle == isShuffle));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isPlaying,
      currentSong,
      position,
      duration,
      playbackSpeed,
      const DeepCollectionEquality().hash(_queue),
      currentIndex,
      repeatMode,
      isShuffle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaybackStateImplCopyWith<_$PlaybackStateImpl> get copyWith =>
      __$$PlaybackStateImplCopyWithImpl<_$PlaybackStateImpl>(this, _$identity);
}

abstract class _PlaybackState implements PlaybackState {
  const factory _PlaybackState(
      {required final bool isPlaying,
      required final Song? currentSong,
      required final Duration position,
      required final Duration duration,
      required final double playbackSpeed,
      required final List<Song> queue,
      required final int currentIndex,
      final RepeatMode repeatMode,
      final bool isShuffle}) = _$PlaybackStateImpl;

  @override
  bool get isPlaying;
  @override
  Song? get currentSong;
  @override
  Duration get position;
  @override
  Duration get duration;
  @override
  double get playbackSpeed;
  @override
  List<Song> get queue;
  @override
  int get currentIndex;
  @override
  RepeatMode get repeatMode;
  @override
  bool get isShuffle;
  @override
  @JsonKey(ignore: true)
  _$$PlaybackStateImplCopyWith<_$PlaybackStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
