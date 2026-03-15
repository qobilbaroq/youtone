import 'package:spotify/spotify.dart';
import '../config/spotify_config.dart';
import '../models/song.dart';
import '../models/playlist.dart';

class SpotifyService {
  late SpotifyApi _spotify;

  SpotifyService() {
    final credentials = SpotifyApiCredentials(
      SpotifyConfig.clientId,
      SpotifyConfig.clientSecret,
    );
    _spotify = SpotifyApi(credentials);
  }

  Future<List<Playlist>> getUserPlaylists() async {
    final playlists = await _spotify.playlists.me.all();
    return playlists.map((p) => Playlist(
      id: p.id ?? '',
      name: p.name ?? '',
      description: p.description ?? '',
      coverArt: p.images?.first.url ?? '',
      songs: [],
    )).toList();
  }

  Future<List<Song>> getPlaylistTracks(String playlistId) async {
    final tracks = await _spotify.playlists.getTracksByPlaylistId(playlistId).all();
    return tracks.map((t) => Song(
      id: t.id ?? '',
      title: t.name ?? '',
      artist: t.artists?.first.name ?? '',
      albumArt: t.album?.images?.first.url ?? '',
      duration: _formatDuration(t.durationMs ?? 0),
    )).toList();
  }

  String _formatDuration(int ms) {
    final duration = Duration(milliseconds: ms);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}