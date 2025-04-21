import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/widgets/app_indicator.dart';
import '../../../../core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';
import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: AppColors.white,
                  child: const Center(
                    child: Text(
                      'AUSSIE\nCOLLECTIBLES',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.loginBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'AUSSIE\nCOLLECTABLES',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Enter your Email and password to proceed',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.darkBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.darkBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                prefixIcon: Image.asset(AppImages.tick),
                                hintText: 'Email or Phone number',
                              ),
                              onChanged: (val) {
                                state.email = val;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Email cannot be empty";
                                }
                                if (value.isEmpty) {
                                  return "Email cannot be empty";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                final validate =
                                    formKey.currentState!.validate();
                                if (validate) {
                                  context.read<AuthCubit>().login(context);
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              obscureText: state.isObscureText,
                              onChanged: (val) {
                                state.password = val;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Password cannot be empty";
                                }
                                if (value.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                final validate =
                                    formKey.currentState!.validate();
                                if (validate) {
                                  context.read<AuthCubit>().login(context);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.darkBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.darkBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                prefixIcon: Image.asset(AppImages.lock),
                                suffixIcon: IconButton(
                                  onPressed: () => context
                                      .read<AuthCubit>()
                                      .toggleObscureText(),
                                  icon: Icon(
                                    state.isObscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: AppColors.darkBlue,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                final validate =
                                    formKey.currentState!.validate();
                                if (validate) {
                                  context.read<AuthCubit>().login(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkBlue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: state.isLoading
                                  ? AppIndicator()
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
