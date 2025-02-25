import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/presentation/logic/home/side_panel/side_panel_state.dart';

import '../../../../navigation/app_navigation.dart';
import '../../../view/home/components/side_panel/components/side_panel_item.dart';

class SidePanelCubit extends Cubit<SidePanelState> {
  SidePanelCubit() : super(SidePanelState.initial()) {
    emit(state);
  }

  void setSelectedIndex(
    int index,
    BuildContext context,
    String routeName,
  ) {
    emit(state.copyWith(selectedIndex: index));
    if (index == SidePanelItemList.sidePanelItems.length - 1) {
      emit(state.copyWith(selectedIndex: 0));
    }

    AppNavigation.pushReplacementNamed(context, routeName);
  }
}
