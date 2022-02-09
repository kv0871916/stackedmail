// ignore_for_file: unused_import, deprecated_member_use
import 'package:better_player/better_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// import 'package:webview_flutter/webview_flutter.dart';

//🚀 video player in product detail screen

class ProductWebVideoWidget extends StatefulWidget {
  const ProductWebVideoWidget({Key? key}) : super(key: key);

  @override
  State<ProductWebVideoWidget> createState() => _ProductWebVideoWidgetState();
}

class _ProductWebVideoWidgetState extends State<ProductWebVideoWidget> {
  // WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    String _url = "assets/header.mp4";

    return BetterPlayer.file(
      _url,
      betterPlayerConfiguration: const BetterPlayerConfiguration(
          fullScreenByDefault: false,
          aspectRatio: 16 / 9,
          autoPlay: true,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableFullscreen: false,
            enableMute: false,
            enableProgressText: false,
            enableProgressBar: false,
            enableProgressBarDrag: false,
            enablePlayPause: false,
            enableSkips: false,
            enableAudioTracks: false,
            playerTheme: BetterPlayerTheme.material,
          ),
          fit: BoxFit.cover),
    );
  }
}

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late Duration videoLength;
  late Duration videoPosition;
  double volume = 0.0;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/header.mp4")
      ..addListener(() => setState(() {
            videoPosition = _controller.value.position;
          }))
      ..initialize().then((_) {
        _controller.setVolume(0);

        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          videoLength = _controller.value.duration;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return (_controller.value.isInitialized)
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(
              _controller,
            ),
          )
        : const CircularProgressIndicator();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
