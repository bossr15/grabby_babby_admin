import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/view/auth/auth_layout.dart';
import 'package:grabby_babby_admin/presentation/view/auth/auth_text_field.dart';

import '../../../../core/styles/app_images.dart';
import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_state.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return AuthLayout(
          isLoading: state.isLoading,
          title: "New Password",
          subTitle: "Enter your new password to proceed",
          buttonText: "New Password",
          onPressed: () {
            final validate = formKey.currentState!.validate();
            if (validate) {
              context.read<AuthCubit>().updatePassword(context);
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
                      context.read<AuthCubit>().updatePassword(context);
                    }
                  },
                  prefixIcon: Image.asset(AppImages.lock),
                  isPasswordField: true,
                ),
                const SizedBox(height: 24),
                AuthTextField(
                  hintText: "Confirm Password",
                  onChanged: (val) {
                    state.confirmPassword = val;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Confirm Password cannot be empty";
                    }
                    if (value.isEmpty) {
                      return "Confirm Password cannot be empty";
                    }
                    if (value != state.password) {
                      return "Password and Confirm Password do not match";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    final validate = formKey.currentState!.validate();
                    if (validate) {
                      context.read<AuthCubit>().updatePassword(context);
                    }
                  },
                  prefixIcon: Image.asset(AppImages.lock),
                  isPasswordField: true,
                ),
              ],
            ),
          ));
    });
  }
}
