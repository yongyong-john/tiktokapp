import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    try {
      final uploadTask = fileRef.putFile(file);

      // NOTE: try-catch와 이 아래부터 필수 코드는 아님
      final taskSnapshot = await uploadTask.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException("Upload timed out!");
        },
      );

      print("Upload completed: ${taskSnapshot.metadata?.fullPath}");
    } catch (e) {
      print("Upload failed: $e");
    } finally {
      print("Upload process completed (success or failure).");
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }
}

final userRepo = Provider((ref) => UserRepository());
