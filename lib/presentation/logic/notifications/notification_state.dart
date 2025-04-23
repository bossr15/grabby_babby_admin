import 'package:grabby_babby_admin/data/models/paginate/paginate.dart';

import '../../../data/models/notification_model/notification_model.dart';

class NotificationState {
  Paginate<NotificationModel> notifications;
  bool isLoading;
  bool isScrolling;

  NotificationState({
    required this.notifications,
    this.isLoading = false,
    this.isScrolling = false,
  });

  factory NotificationState.empty() =>
      NotificationState(notifications: Paginate<NotificationModel>.empty());

  copyWith({
    Paginate<NotificationModel>? notifications,
    bool? isLoading,
    bool? isScrolling,
  }) =>
      NotificationState(
          notifications: notifications ?? this.notifications,
          isLoading: isLoading ?? this.isLoading,
          isScrolling: isScrolling ?? this.isScrolling);
}
