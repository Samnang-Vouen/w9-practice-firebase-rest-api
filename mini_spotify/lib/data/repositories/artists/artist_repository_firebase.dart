import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mini_spotify/data/config/firebase_config.dart';
import 'package:mini_spotify/data/dtos/artist_dto.dart';
import 'package:mini_spotify/data/repositories/artists/artist_repository.dart';
import 'package:mini_spotify/model/artists/artist.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistUri = FirebaseConfig.baseUrl.replace(path: '/artists.json');

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> artistJson = json.decode(response.body);
      return artistJson.entries
          .map((artist) => ArtistDto.fromJson(artist.key, artist.value))
          .toList();
    } else {
      throw Exception('Fail to load artist');
    }
  }

  @override
  Future<Artist?> fetchAristsById(String id) async {
    // TODO: implement fetchAristsById
    throw UnimplementedError();
  }
}
