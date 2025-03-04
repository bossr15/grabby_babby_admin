import 'package:flutter/material.dart';
import 'package:grabby_babby_admin/core/styles/app_color.dart';
import 'package:grabby_babby_admin/core/widgets/g_b_admin_button.dart';
import 'components/security_item.dart';
import '../../../../../core/widgets/g_b_admin_switch.dart';

class LoginSecurity extends StatelessWidget {
  const LoginSecurity({super.key});

  @override
  Widget build(BuildContext context) {
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
                        value: 'Password',
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SecurityItem(
                        label: 'email@gmail.com',
                        value: 'Change password',
                        valueColor: AppColors.darkBlue,
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              Divider(height: 16),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecurityItem(
                        label: '2-FA authentication',
                        value: 'Phone number',
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Email",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GbAdminSwitch(),
                      SizedBox(height: 8),
                      SecurityItem(
                        label: '+223453453545',
                        value: 'email@gmail.com',
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              Divider(height: 16),
              SecurityItem(
                label: 'Last sign in',
                value: 'today at 18:34, Safari 198.123.23.23',
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Total active sessions (5)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSessionItem(
                    'DESKTOP-6TIG6EC • Kyiv, Ukraine',
                    'Chrome • Used right now',
                  ),
                  Divider(height: 16),
                  _buildSessionItem(
                    'iPhone 11 • Kyiv, Ukraine',
                    'Chrome • 04/19/2022',
                  ),
                  Divider(height: 50),
                  Center(
                    child: GbAdminButton(
                      label: "Reset all active sessions",
                      onPressed: () {},
                      backgroundColor: AppColors.darkBlue,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSessionItem(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
