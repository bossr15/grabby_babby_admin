import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grabby_babby_admin/presentation/logic/home/side_panel/side_panel_cubit.dart';

import 'presentation/logic/auth/auth_cubit.dart';
import 'services/local_storage_service.dart';

class Initializer {
  static Future<void> initialize() async {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
  }

  static final blocProviders = [
    BlocProvider<SidePanelCubit>(
      create: (BuildContext context) => SidePanelCubit(),
    ),
    BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
    ),
  ];
}

final localStorage = LocalStorageService.instance;
