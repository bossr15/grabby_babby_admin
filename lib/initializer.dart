import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grabby_babby_admin/network/network_repository.dart';
import 'presentation/logic/auth/auth_cubit.dart';
import 'services/image_service.dart';
import 'services/local_storage_service.dart';

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
}

final localStorage = LocalStorageService.instance;
final imagePickerService = ImagePickRepository();
final networkRepository = NetworkRepository();
