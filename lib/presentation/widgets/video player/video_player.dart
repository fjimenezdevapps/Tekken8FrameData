import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekkenframadata/domain/entities/character_frame_data.dart';
import 'package:tekkenframadata/presentation/providers/character/selected_character_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends ConsumerStatefulWidget {
  final FramesNormal move;

  const VideoPlayer({super.key, required this.move});

  @override
  ConsumerState<VideoPlayer> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayer> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoController();
  }

  void _initializeVideoController() {
    final selectedCharacter = ref.read(selectedCharacterProvider);

    final matchingVideos = selectedCharacter.videoListMoves
        .where((video) =>
            video.command.toLowerCase() == widget.move.command.toLowerCase())
        .toList();

    if (matchingVideos.isNotEmpty) {
      final matchingVideo = matchingVideos.first;
      final videoId =
          YoutubePlayer.convertUrlToId(matchingVideo.initialVideoId) ?? '';

      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
            startAt: matchingVideo.startAt,
            endAt: matchingVideo.endAt,
            autoPlay: false,
            mute: true,
            loop: true),
      )..addListener(_playerListener);
    }
  }

  void _playerListener() {
    if (_controller != null && mounted) {
      setState(() {
        _isPlayerReady = true;
      });
    }
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) return const SizedBox.shrink();

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) => Column(
        children: [
          player,
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _isPlayerReady
                ? () => _controller
                    ?.seekTo(Duration(seconds: _controller!.flags.startAt))
                : null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
            child: const Text('Replay'),
          )
        ],
      ),
    );
  }
}
