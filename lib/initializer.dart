import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grabby_babby_admin/network/network_repository.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'presentation/logic/auth/auth_cubit.dart';
import 'services/image_service.dart';
import 'services/local_storage_service.dart';
import 'services/socket_service.dart';

class Initializer {
  static Future<void> initialize() async {
    await GetStorage.init();
    WidgetsFlutterBinding.ensureInitialized();
  }

  static final blocProviders = [
    BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
    ),
  ];

  static Widget responsiveWrapper(BuildContext context, Widget widget) {
    return ResponsiveWrapper.builder(
      MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1),
        ),
        child: widget,
      ),
      defaultScale: true,
      breakpoints: const [
        ResponsiveBreakpoint.autoScaleDown(450, name: MOBILE),
        ResponsiveBreakpoint.autoScaleDown(800, name: TABLET),
        ResponsiveBreakpoint.autoScaleDown(1920, name: DESKTOP),
      ],
    );
  }
}

final localStorage = LocalStorageService.instance;
final imagePickerService = ImagePickRepository();
final networkRepository = NetworkRepository();
late SocketService appSocket;
