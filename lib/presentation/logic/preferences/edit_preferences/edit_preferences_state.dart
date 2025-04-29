import 'package:grabby_babby_admin/data/models/preferences_model/preferences_model.dart';

class EditPreferencesState {
  PreferencesModel preference;
  List<PreferencesModel> preferences;
  List<PreferencesModel> selectedPreferences;
  bool isLoading;
  bool fetchingPreferences;
  EditPreferencesState({
    required this.preference,
    required this.preferences,
    required this.selectedPreferences,
    this.isLoading = false,
    this.fetchingPreferences = false,
  });

  factory EditPreferencesState.initial() => EditPreferencesState(
      preference: PreferencesModel(), preferences: [], selectedPreferences: []);

  EditPreferencesState copyWith(
      {PreferencesModel? preference,
      bool? isLoading,
      bool? fetchingPreferences,
      List<PreferencesModel>? selectedPreferences,
      List<PreferencesModel>? preferences}) {
    return EditPreferencesState(
      selectedPreferences: selectedPreferences ?? this.selectedPreferences,
      fetchingPreferences: fetchingPreferences ?? this.fetchingPreferences,
      preference: preference ?? this.preference,
      isLoading: isLoading ?? this.isLoading,
      preferences: preferences ?? this.preferences,
    );
  }
}
