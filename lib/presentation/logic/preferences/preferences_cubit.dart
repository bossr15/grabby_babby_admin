import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/data/repositories/preferences_repository/preferences_repository.dart';
import 'package:grabby_babby_admin/presentation/logic/preferences/preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  final preferencesRepository = PreferencesRepository();
  PreferencesCubit() : super(PreferencesState.initial()) {
    getPreferences();
  }

  void getPreferences() {
    emit(state.copyWith(isLoading: true));
    preferencesRepository.getPreferences(extraQuery: {"isParent": true}).then(
      (preferences) => preferences.fold(
        (error) {
          emit(state.copyWith(isLoading: false));
        },
        (data) {
          emit(state.copyWith(isLoading: false, preferences: data));
        },
      ),
    );
  }
}
