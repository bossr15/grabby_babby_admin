import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/presentation/logic/notifications/notification_cubit.dart';
import '../../../../../core/styles/app_color.dart';
import '../../../../../core/styles/app_images.dart';
import '../../../../logic/home/side_panel/side_panel_cubit.dart';
import '../../../../logic/home/side_panel/side_panel_state.dart';
import '../../../../logic/notifications/notification_state.dart';
import 'notification_dialog.dart';

class GBAdminAppBar extends StatelessWidget {
  const GBAdminAppBar({super.key});

  static late OverlayEntry _currentNotificationDialog;

  @override
  Widget build(BuildContext context) {
    // ---------------------------------- //
    // ** OPENING NOTIFICATION OVERLAY ** //
    final notificationCubit = context.read<NotificationCubit>();
    final sidePanelCubit = context.read<SidePanelCubit>();
    _currentNotificationDialog = OverlayEntry(builder: (_) {
      return NotificationDialog(
        overlayEntry: _currentNotificationDialog,
        sidePanelCubit: sidePanelCubit,
        notificationCubit: notificationCubit,
      );
    });
    // ** OPENING NOTIFICATION OVERLAY ** //
    // ---------------------------------- //

    return BlocBuilder<SidePanelCubit, SidePanelState>(
      builder: (sidePanelContext, sidePanelState) {
        return Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text(
                'Hello ${sidePanelState.appUser.fullName}',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.black,
                ),
              ),
              SizedBox(width: 5),
              Image.asset(AppImages.waveHand),
              const Spacer(),
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (notificationContext, notificationState) {
                  final count = notificationState.notifications
                      .getCachedData()
                      .where((item) => item.isNew)
                      .length;
                  return InkWell(
                    onTap: () {
                      notificationCubit.markAsUnread();
                      Overlay.of(context).insert(_currentNotificationDialog);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: appGradient, shape: BoxShape.circle),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Badge.count(
                          count: count,
                          offset: const Offset(10, -10),
                          isLabelVisible: count != 0,
                          child: Image.asset(
                            AppImages.appBarNotification,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  sidePanelState.appUser.url ?? "",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
