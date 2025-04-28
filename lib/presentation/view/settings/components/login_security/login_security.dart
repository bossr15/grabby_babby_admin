import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/presentation/view/settings/components/login_security/components/change_password.dart';
import '../../../../logic/settings/settings_cubit.dart';
import '../../../../logic/settings/settings_state.dart';
import 'components/security_item.dart';

class LoginSecurity extends StatelessWidget {
  const LoginSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Security',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(height: 16),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SecurityItem(
                            label: 'Sign-in Email',
                            value: 'Phone number',
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SecurityItem(
                            label: '${state.user.email}',
                            value: '${state.user.phoneNumber}',
                          ),
                          InkWell(
                            onTap: () {
                              cubit.toggleIsChangeingPassword();
                            },
                            child: Text(
                              "Change password",
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.isChangingPassword)
                    Expanded(child: ChangePassword()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
