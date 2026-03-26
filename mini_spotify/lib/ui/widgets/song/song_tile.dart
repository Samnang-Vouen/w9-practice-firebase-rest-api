import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.artistName,
    required this.artistGenre,
    required this.isPlaying,
    required this.onTap,
    required this.onLike,
  });

  final Song song;
  final String artistName;
  final String artistGenre;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: ClipOval(
            child: Image.network(
              '${song.imageUrl}',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(song.title),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('${song.duration.inMinutes} mins'),
                  SizedBox(width: 20),
                  Text('${song.likes} likes'),
                  SizedBox(width: 20),
                  Text('$artistName - $artistGenre'),
                ],
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isPlaying ? "Playing" : "",
                style: const TextStyle(color: Colors.amber),
              ),
              IconButton(
                onPressed: onLike,
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
