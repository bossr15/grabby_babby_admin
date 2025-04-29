import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:grabby_babby_admin/presentation/logic/preferences/edit_preferences/edit_preferences_cubit.dart';

import '../../../../core/styles/app_color.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_indicator.dart';
import '../../../../core/widgets/g_b_admin_button.dart';
import '../../../logic/preferences/edit_preferences/edit_preferences_state.dart';
import '../../settings/components/account_settings/components/profile_image_picker.dart';
import '../../settings/components/account_settings/components/settings_text_field.dart';
import '../components/preferences_multiselect.dart';

class EditPreferences extends StatelessWidget {
  final String id;
  const EditPreferences({super.key, required this.id});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPreferencesCubit(preferencesId: id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                AppBackButton(),
                const Gap(16),
                const Text(
                  'Update Preference',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
              ],
            ),
            const Gap(24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<EditPreferencesCubit, EditPreferencesState>(
                  builder: (context, state) {
                    final cubit = context.read<EditPreferencesCubit>();

                    return state.fetchingPreferences
                        ? AppIndicator(color: AppColors.darkBlue)
                        : Padding(
                            padding: const EdgeInsets.all(24),
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileImagePicker(
                                      image: state.preference.url,
                                      onImageChanged: (image) {
                                        state.preference.url = image;
                                        cubit.updateState();
                                      },
                                    ),
                                    Gap(24),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SettingsTextField(
                                            controller: TextEditingController(
                                                text: state.preference.name),
                                            onChanged: (val) {
                                              state.preference.name = val;
                                            },
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return 'Please enter preferences name';
                                              }
                                              return null;
                                            },
                                            label: 'Name',
                                            hintText:
                                                'Please enter preferences name',
                                          ),
                                        ),
                                        Gap(10),
                                        PreferencesMultiselect(
                                          onAdd: (item) {
                                            cubit.addItem(item);
                                          },
                                          onDelete: (item) {
                                            cubit.removeItem(item);
                                          },
                                          items: state.preferences,
                                          selectedItems:
                                              state.selectedPreferences,
                                        ),
                                        Gap(10),
                                      ],
                                    ),
                                    Gap(24),
                                    Row(
                                      children: [
                                        GbAdminButton(
                                          label: 'Update Preference',
                                          onPressed: () {
                                            if (formKey.currentState!
                                                    .validate() &&
                                                state.preference.url != null &&
                                                state.selectedPreferences
                                                    .isNotEmpty) {
                                              cubit.editPreferences(context);
                                            } else {
                                              showCustomSnackbar(
                                                  context: context,
                                                  message:
                                                      'Please fill all fields');
                                            }
                                          },
                                          widget: state.isLoading
                                              ? AppIndicator()
                                              : null,
                                          backgroundColor: AppColors.darkBlue,
                                          textColor: AppColors.white,
                                        ),
                                        SizedBox(width: 16),
                                        GbAdminButton(
                                          label: 'Reset',
                                          onPressed: () {
                                            cubit.resetState();
                                          },
                                          backgroundColor: AppColors.white,
                                          textColor: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
