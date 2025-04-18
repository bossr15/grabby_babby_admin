import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/initializer.dart';

import '../../navigation/route_generator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class GBAdmin extends StatelessWidget {
  const GBAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Initializer.blocProviders,
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Aussie Collectables',
        theme: ThemeData(
          fontFamily: 'Archivo',
          dialogBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
