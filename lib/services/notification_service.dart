import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:grabby_babby_admin/data/repositories/user_repository/user_repository.dart';
import '../data/models/notification_model/notification_model.dart';

class NotificationService {
  final userRepository = UserRepository();
  final fcm = FirebaseMessaging.instance;
  final _onMessageController = StreamController<NotificationModel>.broadcast();
  Stream<NotificationModel> get onMessage => _onMessageController.stream;

  Future<void> initialize() async {
    if (kIsWeb) {
      await requestNotificationPermission();
      handleForegroundNotification();
    }
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("User granted provisional permission");
    } else {
      log("User declined or has not accepted permission");
    }
  }

  Future<void> handleForegroundNotification() async {
    log("FOREGROUND LISTENER INITIALIZED");
    FirebaseMessaging.onMessage.listen(
      handleMessage,
      onError: (obj) {
        log("Error handling foreground notification: ${obj.toString()}");
      },
      onDone: () {
        log("Foreground notification listener done");
      },
    );
  }

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    if (message.notification != null) {
      addNotification(message);
      log("FOREGROUND MESSAGE RECIEVED: ${message.notification?.body}");
      log("FOREGROUND MESSAGE RECIEVED: ${message.notification?.title}");
    }
  }

  Future<void> addNotification(RemoteMessage? message) async {
    if (message?.data != null) {
      final notification = NotificationModel(
        message: message?.notification?.body ?? "",
        title: message?.notification?.title,
        isNew: true,
      );
      _onMessageController.add(notification);
    }
  }
}
