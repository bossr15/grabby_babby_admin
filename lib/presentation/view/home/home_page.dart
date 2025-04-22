import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/extension.dart';
import '../../../core/styles/app_color.dart';
import '../../logic/home/side_panel/side_panel_cubit.dart';
import 'components/app_bar/g_b_admin_app_bar.dart';
import 'components/side_panel/side_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.width < 1200;

    return BlocProvider(
      create: (context) => SidePanelCubit(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: isSmallScreen
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              )
            : null,
        drawer: isSmallScreen ? const Drawer(child: SidePanel()) : null,
        body: Row(
          children: [
            if (!isSmallScreen) const SidePanel(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    const GBAdminAppBar(),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
