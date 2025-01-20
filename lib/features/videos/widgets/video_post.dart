import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/common/widgets/video_config/video_config.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/videos/widgets/video_button.dart';
import 'package:tiktokapp/features/videos/widgets/video_comments.dart';
import 'package:tiktokapp/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController = VideoPlayerController.asset("assets/videos/video1.mp4");
  late final AnimationController _animationController;

  final Duration _duration = const Duration(milliseconds: 200);
  bool _isPaused = false;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration == _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    // NOTE: Browser는 첫 번째 Load에서 소리를 포함한 영상을 재생하지 않도록 됨
    // 따라서 첫 번째 Load에서 영상을 재생 시 소리를 mute하여 재생할 수 있음
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _duration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChange(VisibilityInfo info) {
    // NOTE: Widget이 tree에 있다면 mount는 true를 return.
    if (!mounted) return;
    if (info.visibleFraction == 1 && !_isPaused && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      // NOTE: Bottom navigation 화면 이동 후 돌아왔을 때, 영상을 다시 재생하기 위해 2번 토글.
      // 1회 토글 시 일시정지로 유지
      _onTogglePause();
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (!mounted) return;
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // NOTE: ModalBottomSheet의 높이 설정을 위해 true로 변경.
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
    );
    if (!_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: 이와 같이 VideoCofig의 직접적인 사용은 옳지 못 함
    // final videoCOnfig = context.dependOnInheritedWidgetOfExactType<VideoConfig>();
    // VideoConfig에서 construct function인 of를 만들어 호출하여 사용
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChange,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _duration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              onPressed: () {
                VideoConfigData.of(context).toggleMuted();
              },
              icon: FaIcon(
                VideoConfigData.of(context).autoMute ? FontAwesomeIcons.volumeOff : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@ID",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v12,
                Text(
                  "This is so cute kitty video.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage("https://avatars.githubusercontent.com/u/3612017"),
                  child: Text("Profile"),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(232321432),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(4423),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
