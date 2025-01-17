import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/videos/video_preview_screen.dart';

class VideoRecodingScreen extends StatefulWidget {
  static const String routeName = 'postVideo';
  static const String routeURL = '/upload';
  const VideoRecodingScreen({super.key});

  @override
  State<VideoRecodingScreen> createState() => _VideoRecodingScreenState();
}

class _VideoRecodingScreenState extends State<VideoRecodingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late FlashMode _flashMode;
  late CameraController _cameraController;

  late final AnimationController _buttonAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      },
    );
  }

  Future<void> initPermissions() async {
    final camearaPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied = camearaPermission.isDenied || camearaPermission.isPermanentlyDenied;
    final micDenied = micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_noCamera) return;
    // NOTE: Applicaion은 화면이 앞에 떠 있어도 동작되지 않는 것으로 보기에
    // 권한 Dialog가 나오면 inactive로 판단하므로 권한이 없으면 되돌아 감
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    print(cameras);

    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 0 : 1],
      ResolutionPreset.high,
    );

    await _cameraController.initialize();
    // NOTE: This method for only iOS (영상과 오디오의 싱크를 맞추도록 함)
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    // NOTE: didChangeAppLifecycleState()를 async-await를 사용하지 않기 위해 setState를 마지막에 호출
    setState(() {});
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    // NOTE: CameraController에서 사진을 얻는 방법
    // final photo = await _cameraController.takePicture();
    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) return;
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: !_hasPermission
              ? const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Initializing...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size20,
                      ),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    // NOTE: 꽉 찬 화면으로 카메라를 설정하기 위한 BoxFit 설정
                    // FittedBox(
                    //   fit: BoxFit.cover,
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height,
                    //     child: CameraPreview(_cameraController),
                    //   ),
                    // ),
                    if (!_noCamera && _cameraController.value.isInitialized) CameraPreview(_cameraController),
                    const Positioned(
                      top: Sizes.size10,
                      left: Sizes.size10,
                      child: CloseButton(
                        color: Colors.white,
                      ),
                    ),
                    if (!_noCamera)
                      Positioned(
                        top: Sizes.size32,
                        right: Sizes.size5,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: _toggleSelfieMode,
                              icon: const Icon(
                                Icons.cameraswitch,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _setFlashMode(FlashMode.auto),
                              icon: Icon(
                                Icons.flash_auto_rounded,
                                color: _flashMode == FlashMode.auto ? Colors.amber.shade200 : Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _setFlashMode(FlashMode.always),
                              icon: Icon(
                                Icons.flash_on_rounded,
                                color: _flashMode == FlashMode.always ? Colors.amber.shade200 : Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _setFlashMode(FlashMode.off),
                              icon: Icon(
                                Icons.flash_off_rounded,
                                color: _flashMode == FlashMode.off ? Colors.amber.shade200 : Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _setFlashMode(FlashMode.torch),
                              icon: Icon(
                                Icons.flashlight_on,
                                color: _flashMode == FlashMode.torch ? Colors.amber.shade200 : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Positioned(
                      bottom: Sizes.size40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTapUp: (details) => _stopRecording(),
                            onTapDown: _startRecording,
                            child: ScaleTransition(
                              scale: _buttonAnimation,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: Sizes.size60 + Sizes.size10,
                                    height: Sizes.size60 + Sizes.size10,
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                      strokeWidth: Sizes.size6,
                                      value: _progressAnimationController.value,
                                    ),
                                  ),
                                  Container(
                                    width: Sizes.size60,
                                    height: Sizes.size60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
