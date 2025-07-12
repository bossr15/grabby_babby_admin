import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/widgets/app_indicator.dart';
import 'package:grabby_babby_admin/presentation/logic/settings/settings_cubit.dart';
import '../../../../../core/styles/app_color.dart';
import '../../../../logic/settings/settings_state.dart';
import 'components/profile_image_picker.dart';
import 'components/settings_text_field.dart';
import '../../../../../core/widgets/g_b_admin_button.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImagePicker(
                  image: state.profileUrl.isEmpty
                      ? state.user.url
                      : state.profileUrl,
                  onImageChanged: (image) {
                    cubit.setProfileUrl(image);
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SettingsTextField(
                        controller: cubit.fullName,
                        onChanged: (val) {},
                        label: 'Full name',
                        hintText: 'Please enter your full name',
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: SettingsTextField(
                        controller:
                            TextEditingController(text: state.user.email),
                        readOnly: true,
                        label: 'Email',
                        onChanged: (value) {},
                        hintText: 'Please enter your email',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SettingsTextField(
                        controller: cubit.phoneNumber,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {},
                        label: 'Phone number',
                        hintText: 'Please enter your phone number',
                        prefix: '+1',
                      ),
                    ),
                    SizedBox(width: 24),
                    Spacer(),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    GbAdminButton(
                      label: 'Update Profile',
                      onPressed: () {
                        cubit.updateProfile(context);
                      },
                      widget: state.isLoading ? AppIndicator() : null,
                      backgroundColor: AppColors.darkBlue,
                      textColor: AppColors.white,
                    ),
                    SizedBox(width: 16),
                    GbAdminButton(
                      label: 'Reset',
                      onPressed: () {
                        cubit.resetState(context);
                      },
                      backgroundColor: AppColors.white,
                      textColor: AppColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
