import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  static final instance = LocalStorageService._();
  factory LocalStorageService() => instance;
  LocalStorageService._();

  final storage = GetStorage();
  void setString(String key, String value) {
    storage.write(key, value);
  }

  String? getString(String key) {
    return storage.read(key);
  }

  void clear() {
    storage.erase();
  }
}
