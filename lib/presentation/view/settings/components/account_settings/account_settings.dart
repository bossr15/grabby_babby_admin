import 'package:flutter/material.dart';
import '../../../../../core/styles/app_color.dart';
import 'components/profile_image_picker.dart';
import 'components/settings_text_field.dart';
import '../../../../../core/widgets/g_b_admin_button.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileImagePicker(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SettingsTextField(
                  label: 'Full name',
                  hintText: 'Please enter your full name',
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: SettingsTextField(
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
                  onChanged: (value) {},
                  label: 'Username',
                  hintText: 'Please enter your username',
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: SettingsTextField(
                  onChanged: (value) {},
                  label: 'Phone number',
                  hintText: 'Please enter your phone number',
                  prefix: '+1',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SettingsTextField(
            onChanged: (value) {},
            label: 'Bio',
            hintText: 'Write your Bio here e.g your hobbies, interests ETC',
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              GbAdminButton(
                label: 'Update Profile',
                onPressed: () {},
                backgroundColor: AppColors.darkBlue,
                textColor: AppColors.white,
              ),
              SizedBox(width: 16),
              GbAdminButton(
                label: 'Reset',
                onPressed: () {},
                backgroundColor: AppColors.white,
                textColor: AppColors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
