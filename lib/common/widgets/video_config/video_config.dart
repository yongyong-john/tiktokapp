import 'package:flutter/material.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoPlay = false;

  void toggleIsMute() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoPlay() {
    isAutoPlay = !isAutoPlay;
    notifyListeners();
  }
}

// final videoConfig = VideoConfig();
// final videoConfig = ValueNotifier(false);
