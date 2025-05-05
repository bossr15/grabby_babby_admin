import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/models/notification_model/notification_model.dart';
import 'package:grabby_babby_admin/data/models/paginate/paginate.dart';
import 'package:grabby_babby_admin/data/repositories/notification_repository/notification_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/notifications/notification_state.dart';

import '../../../initializer.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final notificationRepository = NotificationRepository();
  final scrollController = ScrollController();
  late StreamSubscription? _messageSubscription;

  NotificationCubit() : super(NotificationState.empty()) {
    _setupNotifications();
    fetchNotifications();
  }
  void _setupNotifications() async {
    await notificationService.initialize();
    _messageSubscription = notificationService.onMessage.listen((message) {
      addNotification(message);
    });
  }

  void markAsUnread() {
    final notifications = state.notifications.data.map((page, notifications) {
      final items = notifications.map((notification) {
        notification.isNew = false;
        return notification;
      }).toList();
      return MapEntry(page, items);
    });
    emit(state.copyWith(
        notifications: state.notifications.copyWith(data: notifications)));
  }

  void attachListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 200) {
        if (!state.isScrolling &&
            state.notifications.currentPage < state.notifications.totalPages) {
          goToNextPage();
        }
      }
    });
  }

  void fetchNotifications() {
    emit(state.copyWith(isLoading: true));
    notificationRepository
        .getNotifications(previousData: state.notifications)
        .then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(
                isLoading: false,
                isScrolling: false,
              ));
            },
            (data) {
              emit(state.copyWith(
                isLoading: false,
                notifications: data,
                isScrolling: false,
              ));
            },
          ),
        );
  }

  void goToNextPage() {
    state.notifications.currentPage++;
    updateUi();
  }

  void updateUi() {
    if (!state.notifications.hasPageCached(state.notifications.currentPage)) {
      state.isScrolling = true;
      fetchNotifications();
    }
  }

  void addNotification(NotificationModel notification) {
    state.notifications = Paginate<NotificationModel>.appendItem(
        data: state.notifications, item: notification);
    log("NOTIFICATION ADDED: ${notification.title}");
    emit(state.copyWith(notifications: state.notifications));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }
}
