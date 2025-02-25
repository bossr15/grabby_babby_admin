import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/logic/home/side_panel/side_panel_cubit.dart';

class Initializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  static final blocProviders = [
    BlocProvider<SidePanelCubit>(
      create: (BuildContext context) => SidePanelCubit(),
    ),
  ];
}
