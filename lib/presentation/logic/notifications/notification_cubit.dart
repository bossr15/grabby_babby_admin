import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/notification_repository/notification_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/notifications/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final notificationRepository = NotificationRepository();
  final scrollController = ScrollController();

  NotificationCubit() : super(NotificationState.empty()) {
    fetchNotifications();
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
}
