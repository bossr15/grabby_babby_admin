import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/widgets/jumping_dots.dart';
import 'package:grabby_babby_admin/presentation/logic/notifications/notification_cubit.dart';
import 'package:grabby_babby_admin/presentation/logic/notifications/notification_state.dart';
import 'package:grabby_babby_admin/presentation/view/content_management/components/content_item.dart';
import '../../../core/styles/app_color.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationCubit>(
      create: (context) => NotificationCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(16),
          child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
            final cubit = context.read<NotificationCubit>();
            final notifications = state.notifications.getCachedData();
            final isLoading = state.isLoading && !state.isScrolling;
            final isEmpty = notifications.isEmpty;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notification",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: isLoading
                        ? Row(
                            children: [
                              Spacer(),
                              JumpingDots(),
                              Spacer(),
                            ],
                          )
                        : isEmpty
                            ? Center(
                                child: Text("No Notifications available"),
                              )
                            : ListView.separated(
                                controller: cubit.scrollController,
                                itemCount: notifications.length,
                                separatorBuilder: (context, index) => Divider(),
                                itemBuilder: (context, index) {
                                  final notification = notifications[index];
                                  return ContentItem(
                                      notification: notification);
                                },
                              )),
              ],
            );
          }),
        ),
      ),
    );
  }
}
