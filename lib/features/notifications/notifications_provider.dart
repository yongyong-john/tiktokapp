import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repository.dart';
import 'package:tiktokapp/features/inbox/chats_screen.dart';
import 'package:tiktokapp/features/videos/views/video_recoding_screen.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    _db.collection("users").doc(user!.uid).update({"token": token});
  }

  Future<void> initListeners(BuildContext context) async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    // NOTE: Foreground messaging
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage event) {
        print("I just got a message and I'm in the foreground.");
        print(event.notification?.title);
      },
    );

    // NOTE: Background messaging
    FirebaseMessaging.onMessageOpenedApp.listen(
      (notification) {
        print("I just opened the app and I'm in the background.");
        print(notification.data['screen']);
        context.pushNamed(ChatsScreen.routeName);
      },
    );

    // NOTE: Terminated
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      print("I just terminated the app and I'm in the background.");
      print(notification.data['screen']);
      context.pushNamed(VideoRecodingScreen.routeName);
    }
  }

  @override
  FutureOr build(BuildContext context) async {
    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListeners(context);
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
