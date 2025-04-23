import 'package:dartz/dartz.dart';

import '../../../initializer.dart';
import '../../models/notification_model/notification_model.dart';
import '../../models/paginate/paginate.dart';

class NotificationRepository {
  Future<Either<String, Paginate<NotificationModel>>> getNotifications({
    required Paginate<NotificationModel> previousData,
  }) async {
    final response = await networkRepository.get(
      url: "/notifications/get-notifications",
      extraQuery: {
        "page": previousData.currentPage,
        "limit": previousData.pageSize,
      },
    );
    if (!response.failed) {
      final notifications = Paginate<NotificationModel>.mergePagination(
        dataFromJson: NotificationModel.fromJson,
        previousData: previousData,
        newData: response.data,
        dataKey: "notifications",
      );
      return right(notifications);
    }
    return left(response.message);
  }
}
