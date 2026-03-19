import 'package:mini_spotify/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();
  
  Future<Artist?> fetchAristsById(String id);
}