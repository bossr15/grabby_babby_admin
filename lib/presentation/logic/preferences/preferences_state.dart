import 'package:grabby_babby_admin/data/models/preferences_model/preferences_model.dart';

class PreferencesState {
  List<PreferencesModel> preferences;
  bool isLoading;
  PreferencesState({
    required this.preferences,
    this.isLoading = false,
  });

  factory PreferencesState.initial() => PreferencesState(preferences: []);

  PreferencesState copyWith(
      {List<PreferencesModel>? preferences, bool? isLoading}) {
    return PreferencesState(
      preferences: preferences ?? this.preferences,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
