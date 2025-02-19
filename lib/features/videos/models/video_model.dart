class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final int likes;
  final int createAt;
  final int comments;

  VideoModel({
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.creatorUid,
    required this.likes,
    required this.creator,
    required this.createAt,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'creatorUid': creatorUid,
      'creator': creator,
      'likes': likes,
      'createdAt': createAt,
      'comments': comments,
    };
  }
}
