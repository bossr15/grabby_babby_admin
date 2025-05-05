import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/initializer.dart';
import '../../navigation/route_generator.dart';

class GBAdmin extends StatelessWidget {
  const GBAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Aussie Collectables',
      builder: (context, widget) {
        return Initializer.responsiveWrapper(context, widget!);
      },
      theme: ThemeData(
          fontFamily: 'Archivo',
          dialogBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          cardColor: Colors.white,
          useMaterial3: true,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.darkBlue,
            selectionColor: AppColors.lightBlue,
          )),
    );
  }
}
