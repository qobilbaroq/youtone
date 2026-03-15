import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song.dart';
import '../services/youtube_service.dart';

class PlayerNotifier extends StateNotifier<Song?> {
  final AudioPlayer _player = AudioPlayer();
  final YoutubeService _youtubeService = YoutubeService();

  PlayerNotifier() : super(null);

  AudioPlayer get player => _player;

  Future<void> playSong(Song song) async {
    state = song;
    final url = await _youtubeService.getAudioUrl('${song.title} ${song.artist}');
    if (url != null) {
      await _player.setUrl(url);
      await _player.play();
    }
  }

  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  Future<void> seekTo(Duration position) async {
    await _player.seek(position);
  }

  @override
  void dispose() {
    _player.dispose();
    _youtubeService.dispose();
    super.dispose();
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, Song?>((ref) {
  return PlayerNotifier();
});

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  return ref.watch(playerProvider.notifier).player;
});