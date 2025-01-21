import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  void _saveToGallery() async {
    if (_savedVideo) return;

    await ImageGallerySaver.saveFile(
      widget.video.path,
    );

    _savedVideo = true;
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview video'),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(_savedVideo ? FontAwesomeIcons.check : FontAwesomeIcons.download),
            ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final screenHeight = constraints.maxHeight;

                // 영상 원본 비율 (가로 / 세로)
                final videoAspectRatio = _videoPlayerController.value.aspectRatio;
                // 최종 계산될 width, height
                double width = screenWidth;
                double height = width / videoAspectRatio;

                // 만약 계산된 height가 화면 높이를 넘어버리면,
                // 높이를 화면에 맞추고, 그에 따른 너비를 다시 계산
                if (height > screenHeight) {
                  height = screenHeight;
                  width = height * videoAspectRatio;
                }

                return Center(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
