import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    //NOTE: 해당 ViewModel에 다시 loading 되도록 함
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 3)); // test용 dealy
    _list = [..._list];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception("Make Error Throw");
    return _list;
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
