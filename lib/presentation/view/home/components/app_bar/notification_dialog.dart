import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/presentation/logic/notifications/notification_cubit.dart';

import '../../../../../core/styles/app_color.dart';
import '../../../../../data/models/notification_model/notification_model.dart';
import '../../../../../navigation/route_name.dart';
import '../../../../logic/home/side_panel/side_panel_cubit.dart';
import '../../../../logic/notifications/notification_state.dart';
import '../../../content_management/components/content_item.dart';

class NotificationDialog extends StatefulWidget {
  const NotificationDialog({
    super.key,
    required this.overlayEntry,
    required this.sidePanelCubit,
    required this.notificationCubit,
  });

  final OverlayEntry overlayEntry;
  final NotificationCubit notificationCubit;
  final SidePanelCubit sidePanelCubit;

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationController.reverse().then((_) {
          widget.overlayEntry.remove();
        });
      },
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 140, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: context.width * 0.2,
                  height: context.height * 0.5,
                  child: _buildContent(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      bloc: widget.notificationCubit,
      builder: (context, state) {
        List<NotificationModel> notifications =
            state.notifications.getCachedData();
        final isEmpty = notifications.isEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: isEmpty
                  ? Center(
                      child: Text("No Notifications available"),
                    )
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return ContentItem(notification: notification);
                      },
                    ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: SizedBox(
                width: context.width * 0.2,
                child: InkWell(
                  onTap: () {
                    _animationController.reverse().then((_) {
                      widget.overlayEntry.remove();
                      widget.sidePanelCubit.setSelectedIndex(
                          6, context, RouteName.notifications);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: appGradient2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Text(
                        isEmpty ? "Go to Notifications" : 'View All',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
