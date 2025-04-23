import 'package:grabby_babby_admin/data/models/user_model/user_model.dart';

class SidePanelState {
  final int selectedIndex;
  UserModel appUser;

  SidePanelState({
    required this.selectedIndex,
    required this.appUser,
  });

  factory SidePanelState.initial() => SidePanelState(
        selectedIndex: 0,
        appUser: UserModel(),
      );

  SidePanelState copyWith({
    int? selectedIndex,
    Map<String, int>? notificationCounts,
    UserModel? appUser,
  }) =>
      SidePanelState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        appUser: appUser ?? this.appUser,
      );
}
