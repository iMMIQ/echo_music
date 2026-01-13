import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

/// Current navigation index provider
@riverpod
class CurrentNavigationIndex extends _$CurrentNavigationIndex {
  @override
  int build() => 0;

  /// Set the current navigation index
  set index(int value) => state = value;
}
