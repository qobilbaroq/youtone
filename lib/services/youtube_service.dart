import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<String?> getAudioUrl(String query) async {
    try {
      final results = await _yt.search.search(query);
      final video = results.first;
      final manifest = await _yt.videos.streamsClient.getManifest(video.id);
      final audioStream = manifest.audioOnly.withHighestBitrate();
      return audioStream.url.toString();
    } catch (e) {
      print('Error getting audio URL: $e');
      return null;
    }
  }

  void dispose() {
    _yt.close();
  }
}