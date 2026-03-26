import 'package:flutter/material.dart';
import 'package:mini_spotify/data/repositories/artists/artist_repository.dart';
import 'package:mini_spotify/model/artists/artist.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  final ArtistRepository artistRepository;
  Map<String, Artist> artistById = {};

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.artistRepository,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Song> songs = await songRepository.fetchSongs();
      List<Artist> artists = await artistRepository.fetchArtists();

      for (final artist in artists) {
        artistById[artist.id] = artist;
      }

      songsValue = AsyncValue.success(songs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  String getArtistName(Song song) =>
      artistById[song.artistId]?.name ?? 'Unknown artist';

  String getArtistGenre(Song song) =>
      artistById[song.artistId]?.genre ?? 'Unknown genre';

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
  Future<void> likeSong(Song song) async {
    await songRepository.likeSong(song.id, song.likes);
    fetchSong();
  }
}
