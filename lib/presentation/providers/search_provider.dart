import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/song_model.dart';
import 'library_provider.dart';

part 'search_provider.g.dart';

/// Search query provider
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  set query(String value) => state = value;

  void clear() {
    state = '';
  }
}

/// Search results provider
@riverpod
Future<SearchResults> searchResults(SearchResultsRef ref) async {
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) {
    return const SearchResults(songs: [], albums: [], artists: []);
  }

  final libraryService = ref.watch(libraryServiceProvider);
  final allSongs = await libraryService.getAllSongs();

  // Search songs
  final songs = allSongs.where((song) {
    final lowerQuery = query.toLowerCase();
    return song.title.toLowerCase().contains(lowerQuery) ||
        song.artist.toLowerCase().contains(lowerQuery) ||
        song.album.toLowerCase().contains(lowerQuery);
  }).toList();

  // Extract unique albums from search results
  final albums = <String>{};
  for (final song in songs) {
    albums.add(song.album);
  }

  // Extract unique artists from search results
  final artists = <String>{};
  for (final song in songs) {
    artists.add(song.artist);
  }

  return SearchResults(
    songs: songs,
    albums: albums.toList()..sort(),
    artists: artists.toList()..sort(),
  );
}

/// Search results model
class SearchResults {
  const SearchResults({
    required this.songs,
    required this.albums,
    required this.artists,
  });
  final List<Song> songs;
  final List<String> albums;
  final List<String> artists;

  bool get isEmpty => songs.isEmpty && albums.isEmpty && artists.isEmpty;

  int get totalResults => songs.length + albums.length + artists.length;
}
