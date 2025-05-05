import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/navigation/app_navigation.dart';
import 'package:grabby_babby_admin/navigation/route_name.dart';
import 'package:grabby_babby_admin/presentation/view/auth/auth_layout.dart';
import '../../../../core/styles/app_color.dart';
import '../../../../core/styles/app_images.dart';
import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_state.dart';
import '../auth_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AuthLayout(
          isLoading: state.isLoading,
          title: "Login",
          subTitle: "Enter your Email and password to proceed",
          buttonText: "Login",
          onPressed: () {
            final validate = formKey.currentState!.validate();
            if (validate) {
              context.read<AuthCubit>().login(context);
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                AuthTextField(
                  hintText: "Email",
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
                    final validate = formKey.currentState!.validate();
                    if (validate) {
                      context.read<AuthCubit>().login(context);
                    }
                  },
                  prefixIcon: Image.asset(AppImages.tick),
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  hintText: "Password",
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
                    final validate = formKey.currentState!.validate();
                    if (validate) {
                      context.read<AuthCubit>().login(context);
                    }
                  },
                  prefixIcon: Image.asset(AppImages.lock),
                  isPasswordField: true,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      AppNavigation.pushNamed(RouteName.forgetPassword);
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
