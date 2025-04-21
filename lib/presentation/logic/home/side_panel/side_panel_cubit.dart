import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/presentation/logic/home/side_panel/side_panel_state.dart';

import '../../../../initializer.dart';
import '../../../../navigation/app_navigation.dart';
import '../../../view/home/components/side_panel/components/side_panel_item.dart';

class SidePanelCubit extends Cubit<SidePanelState> {
  SidePanelCubit() : super(SidePanelState.initial()) {
    final panelIndex = localStorage.getString('panelIndex');
    emit(state.copyWith(selectedIndex: int.parse(panelIndex ?? "0")));
  }

  void setSelectedIndex(
    int index,
    BuildContext context,
    String routeName,
  ) {
    localStorage.setString('panelIndex', index.toString());
    emit(state.copyWith(selectedIndex: index));
    if (index == SidePanelItemList.sidePanelItems.length - 1) {
      // this is when user logsOut
      emit(state.copyWith(selectedIndex: 0));
      localStorage.clear();
    }

    AppNavigation.pushReplacementNamed(routeName);
  }
}
