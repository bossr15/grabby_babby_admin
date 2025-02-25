import '../../../../../../core/styles/app_images.dart';
import '../../../../../../navigation/route_name.dart';

class SidePanelItem {
  final String title;
  final String image;
  final String routeName;

  SidePanelItem(
      {required this.title, required this.image, required this.routeName});
}

class SidePanelItemList {
  static final List<SidePanelItem> sidePanelItems = [
    SidePanelItem(
      title: 'Dashboard',
      image: AppImages.dashboard,
      routeName: RouteName.dashboard,
    ),
    SidePanelItem(
      title: 'User Management',
      image: AppImages.users,
      routeName: RouteName.users,
    ),
    SidePanelItem(
      title: 'Transaction Management',
      image: AppImages.transactions,
      routeName: RouteName.transactions,
    ),
    SidePanelItem(
      title: 'Analytics and Reporting',
      image: AppImages.analytics,
      routeName: RouteName.analytics,
    ),
    SidePanelItem(
      title: 'Content Moderation',
      image: AppImages.contentManagement,
      routeName: RouteName.contentManagement,
    ),
    SidePanelItem(
      title: 'Notifications',
      image: AppImages.notifications,
      routeName: RouteName.notifications,
    ),
    SidePanelItem(
      title: 'Settings',
      image: AppImages.settings,
      routeName: RouteName.settings,
    ),
    SidePanelItem(
      title: 'Support Management',
      image: AppImages.supportManagement,
      routeName: RouteName.supportManagement,
    ),
    SidePanelItem(
      title: 'Log Out',
      image: AppImages.logout,
      routeName: RouteName.login,
    ),
  ];
}
