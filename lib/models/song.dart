class Song {
  final String id;
  final String title;
  final String artist;
  final String albumArt;
  final String duration;
  String? youtubeUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumArt,
    required this.duration,
    this.youtubeUrl,
  });
}
