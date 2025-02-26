import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/videos/models/video_model.dart';
import 'package:tiktokapp/features/videos/repos/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatesAt}) async {
    final result = await _repository.fetchVideos(lastItemCreatesAt: lastItemCreatesAt);
    final videos = result.docs.map(
      (doc) => VideoModel.fromJson(
        json: doc.data(),
        videoId: doc.id,
      ),
    );
    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    // throw Exception("Make Error Throw");
    _repository = ref.read(videosRepo);
    _list = await _fetchVideos(lastItemCreatesAt: null);
    return _list;
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchVideos(lastItemCreatesAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatesAt: null);
    _list = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider = AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
