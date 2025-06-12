import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/view/settings/components/account_settings/components/settings_text_field.dart';

import '../../../../../../core/styles/app_color.dart';
import '../../../../../../core/widgets/app_indicator.dart';
import '../../../../../../core/widgets/g_b_admin_button.dart';
import '../../../../../logic/settings/settings_cubit.dart';
import '../../../../../logic/settings/settings_state.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
      final cubit = context.read<SettingsCubit>();

      return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(height: 16),
            Row(
              children: [
                Expanded(
                  child: SettingsTextField(
                    label: 'Current Password',
                    onChanged: (val) {},
                    controller: cubit.currentPassword,
                    hintText: 'Enter your current password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                ),
                Spacer(),
                Expanded(
                  child: SettingsTextField(
                    label: 'New Password',
                    onChanged: (val) {},
                    controller: cubit.newPassword,
                    hintText: 'Enter your new password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      } else if (value.length < 5) {
                        return 'Password must be at least 5 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 16),
                GbAdminButton(
                  label: 'Update Password',
                  onPressed: () {
                    final validate = formKey.currentState!.validate();
                    if (validate) {
                      cubit.updatePassword(context);
                    }
                  },
                  widget: state.isPasswordLoading ? AppIndicator() : null,
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
      );
    });
  }
}
