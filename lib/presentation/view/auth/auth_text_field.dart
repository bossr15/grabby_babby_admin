import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/styles/app_color.dart';

class AuthTextField extends StatefulWidget {
  final String hintText;
  final Widget? prefixIcon;
  final bool isPasswordField;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.inputFormatters,
    this.prefixIcon,
    this.isPasswordField = false,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.enabled = true,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final ValueNotifier<bool> _obscureTextNotifier;

  @override
  void initState() {
    super.initState();
    _obscureTextNotifier = ValueNotifier<bool>(widget.isPasswordField);
  }

  @override
  void dispose() {
    _obscureTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureTextNotifier,
      builder: (context, isObscured, _) {
        return TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: isObscured,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppColors.grey,
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    onPressed: () {
                      _obscureTextNotifier.value = !_obscureTextNotifier.value;
                    },
                    icon: Icon(
                      isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(0xff666666),
                      size: 20,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }
}
