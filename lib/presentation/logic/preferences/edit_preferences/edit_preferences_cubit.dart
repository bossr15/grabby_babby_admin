import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/preferences_repository/preferences_repository.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import '../../../../core/utils/utils.dart';
import '../../../../data/models/preferences_model/preferences_model.dart';
import 'edit_preferences_state.dart';

class EditPreferencesCubit extends Cubit<EditPreferencesState> {
  final preferencesRepository = PreferencesRepository();
  String preferencesId;
  EditPreferencesCubit({required this.preferencesId})
      : super(EditPreferencesState.initial()) {
    getPreferencesById();
  }

  void getPreferencesById() {
    emit(state.copyWith(fetchingPreferences: true));
    preferencesRepository.getPreferenceById(id: preferencesId).then(
          (preferences) => preferences.fold(
            (error) {
              emit(state.copyWith(fetchingPreferences: false));
            },
            (data) {
              emit(state.copyWith(
                  preference: data, selectedPreferences: data.subPreferences));
              getPreferences();
            },
          ),
        );
  }

  void getPreferences() {
    preferencesRepository.getPreferences(extraQuery: {"isParent": true}).then(
      (preferences) => preferences.fold(
        (error) {
          emit(state.copyWith(fetchingPreferences: false));
        },
        (data) {
          final prefs = data
              .where((item) => item.id.toString() != preferencesId)
              .toList();
          emit(state.copyWith(preferences: prefs, fetchingPreferences: false));
        },
      ),
    );
  }

  void editPreferences(BuildContext context) {
    state.preference.subPreferences = state.selectedPreferences;
    emit(state.copyWith(isLoading: true));
    preferencesRepository.updatePreference(preference: state.preference).then(
          (preferences) => preferences.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
              showCustomSnackbar(
                context: context,
                message: error,
                type: SnackbarType.error,
              );
            },
            (data) {
              showCustomSnackbar(
                context: context,
                message: 'Preference updated successfully',
                type: SnackbarType.success,
              );
              emit(state.copyWith(
                isLoading: false,
                preference: data,
              ));
              AppNavigation.pop<bool>(true);
            },
          ),
        );
  }

  void updateState() {
    emit(state.copyWith(preference: state.preference));
  }

  void resetState() {
    emit(EditPreferencesState.initial());
    getPreferencesById();
  }

  void removeItem(ChildPreferences item) {
    state.selectedPreferences.remove(item);
    emit(state.copyWith(selectedPreferences: state.selectedPreferences));
  }

  void addItem(PreferencesModel pref) {
    final item = ChildPreferences(id: pref.id, child: pref);
    if (state.selectedPreferences.contains(item)) {
      return;
    }
    state.selectedPreferences.add(item);
    emit(state.copyWith(selectedPreferences: state.selectedPreferences));
  }
}
