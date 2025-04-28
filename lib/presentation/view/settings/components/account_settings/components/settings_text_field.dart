import 'package:flutter/material.dart';

class SettingsTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? prefix;
  final int maxLines;
  final bool readOnly;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const SettingsTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.validator,
    this.controller,
    this.readOnly = false,
    this.prefix,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          readOnly: readOnly,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixText: prefix,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
