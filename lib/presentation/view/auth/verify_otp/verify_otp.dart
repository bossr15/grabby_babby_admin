import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabby_babby_admin/core/utils/utils.dart';
import 'package:grabby_babby_admin/presentation/view/auth/auth_layout.dart';
import 'package:grabby_babby_admin/presentation/view/auth/auth_text_field.dart';

import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_state.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      final cubit = context.read<AuthCubit>();
      return AuthLayout(
        isLoading: state.isLoading,
        title: "Verify Otp",
        subTitle: "Enter 6-digit otp sent to $email",
        buttonText: "Verify Email",
        onPressed: () {
          final validate = cubit.otp.every((digit) => digit.isNotEmpty);
          if (validate) {
            cubit.verifyOtp(context);
          } else {
            showCustomSnackbar(
                context: context, message: "Please enter all digits");
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 55,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: AuthTextField(
                    hintText: " 0",
                    onChanged: (String value) {
                      if (value.isNotEmpty) {
                        cubit.updateOTP(value, index, context);
                      } else {
                        cubit.removeDigit(index);
                      }
                      if (index == 5 && value.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    onFieldSubmitted: (value) {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
