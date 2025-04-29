import 'package:grabby_babby_admin/data/models/preferences_model/preferences_model.dart';

class AddPreferencesState {
  PreferencesModel preference;
  List<PreferencesModel> preferences;
  List<PreferencesModel> selectedPreferences;
  bool isLoading;
  bool fetchingPreferences;
  AddPreferencesState({
    required this.preference,
    required this.preferences,
    required this.selectedPreferences,
    this.isLoading = false,
    this.fetchingPreferences = false,
  });

  factory AddPreferencesState.initial() => AddPreferencesState(
        preference: PreferencesModel(),
        preferences: [],
        selectedPreferences: [],
      );

  AddPreferencesState copyWith(
      {PreferencesModel? preference,
      bool? isLoading,
      bool? fetchingPreferences,
      List<PreferencesModel>? preferences,
      List<PreferencesModel>? selectedPreferences}) {
    return AddPreferencesState(
      preference: preference ?? this.preference,
      isLoading: isLoading ?? this.isLoading,
      fetchingPreferences: fetchingPreferences ?? this.fetchingPreferences,
      preferences: preferences ?? this.preferences,
      selectedPreferences: selectedPreferences ?? this.selectedPreferences,
    );
  }
}
