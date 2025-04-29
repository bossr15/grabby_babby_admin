import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/data/models/preferences_model/preferences_model.dart';
import 'package:grabby_babby_admin/data/repositories/preferences_repository/preferences_repository.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'add_preferences_state.dart';

class AddPreferencesCubit extends Cubit<AddPreferencesState> {
  final preferencesRepository = PreferencesRepository();
  AddPreferencesCubit() : super(AddPreferencesState.initial()) {
    getPreferences();
  }

  void getPreferences() {
    emit(state.copyWith(fetchingPreferences: true));
    preferencesRepository.getPreferences(extraQuery: {
      "isParent": true,
    }).then(
      (preferences) => preferences.fold(
        (error) {
          emit(state.copyWith(fetchingPreferences: false));
        },
        (data) {
          emit(state.copyWith(preferences: data, fetchingPreferences: false));
        },
      ),
    );
  }

  void addPreferences(BuildContext context) {
    state.preference.subPreferences = state.selectedPreferences;
    emit(state.copyWith(isLoading: true));
    preferencesRepository.addPreference(preference: state.preference).then(
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
                message: 'Preference added successfully',
                type: SnackbarType.success,
              );
              emit(state.copyWith(isLoading: false, preference: data));

              AppNavigation.pop();
            },
          ),
        );
  }

  void updateState() {
    emit(state.copyWith(preference: state.preference));
  }

  void resetState() {
    emit(AddPreferencesState.initial());
    getPreferences();
  }

  void removeItem(PreferencesModel item) {
    state.selectedPreferences.remove(item);
    emit(state.copyWith(selectedPreferences: state.selectedPreferences));
  }

  void addItem(PreferencesModel item) {
    if (state.selectedPreferences.contains(item)) {
      return;
    }
    state.selectedPreferences.add(item);
    emit(state.copyWith(selectedPreferences: state.selectedPreferences));
  }
}
