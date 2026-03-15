import 'song.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String coverArt;
  final List<Song> songs;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.coverArt,
    required this.songs,
  });
}