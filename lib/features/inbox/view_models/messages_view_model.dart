import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repository.dart';
import 'package:tiktokapp/features/inbox/models/message_model.dart';
import 'package:tiktokapp/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepo _repo;

  @override
  FutureOr<void> build() {
    _repo = ref.read(messagesRepo);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _repo.sendMessage(message);
    });
  }
}

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);

final chatProvider = StreamProvider.autoDispose<List<MessageModel>>(
  (ref) {
    final db = FirebaseFirestore.instance;
    return db
        .collection("chat_rooms")
        .doc("G85IJyAa3HlsQiTIHcHG")
        .collection("texts")
        .orderBy("createdAt")
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => MessageModel.fromJson(
                  doc.data(),
                ),
              )
              .toList()
              .reversed
              .toList(),
        );
  },
);
