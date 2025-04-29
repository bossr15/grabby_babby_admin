import 'package:dartz/dartz.dart';
import '../../../core/utils/utils.dart';
import '../../../initializer.dart';
import '../../models/preferences_model/preferences_model.dart';

class PreferencesRepository {
  Future<Either<String, List<PreferencesModel>>> getPreferences({
    String? url,
    Map<String, dynamic>? extraQuery,
  }) async {
    final response = await networkRepository.get(
      url: url ?? "/preferences/get-preferences-list",
      extraQuery: extraQuery,
    );

    if (!response.failed) {
      final data = parseList(response.data["data"], PreferencesModel.fromJson);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, PreferencesModel>> addPreference(
      {required PreferencesModel preference}) async {
    final response = await networkRepository.post(
        url: "/preferences/create-new-preferences", data: preference.toJson());

    if (!response.failed) {
      final data = PreferencesModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, PreferencesModel>> updatePreference(
      {required PreferencesModel preference}) async {
    final response = await networkRepository.put(
      url: "/preferences/update-preferences-id/${preference.id}",
      data: preference.toUpdateJson(),
    );

    if (!response.failed) {
      final data = PreferencesModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, PreferencesModel>> getPreferenceById(
      {required String id}) async {
    final response = await networkRepository.get(
        url: "/preferences/get-preferences-detail/$id");

    if (!response.failed) {
      final data = PreferencesModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }

  Future<Either<String, PreferencesModel>> deletePreference(
      {required String id}) async {
    final response = await networkRepository.delete(
        url: "/preferences/delete-preferences-id/$id");

    if (!response.failed) {
      final data = PreferencesModel.fromJson(response.data["data"]);
      return right(data);
    }

    return left(response.message);
  }
}
