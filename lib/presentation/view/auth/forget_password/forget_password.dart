import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/presentation/view/auth/auth_layout.dart';

import '../../../../core/styles/app_images.dart';
import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_state.dart';
import '../auth_text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return AuthLayout(
          isLoading: state.isLoading,
          title: "Forget Password",
          subTitle: "Enter your Email to reset your password",
          buttonText: "Reset Password",
          onPressed: () {
            final validate = formKey.currentState!.validate();
            if (validate) {
              context.read<AuthCubit>().forgetPassword(context);
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
                      context.read<AuthCubit>().forgetPassword(context);
                    }
                  },
                  prefixIcon: Image.asset(AppImages.tick),
                ),
              ],
            ),
          ));
    });
  }
}
