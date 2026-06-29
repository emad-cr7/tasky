import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    required this.controller,
    required this.title,
    this.maxLines,
    required this.hint,
    this.validator,
  });

  final String title;

  final TextEditingController controller;

  final int? maxLines;

  final String hint;

  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.labelSmall
        ),
        SizedBox(height: AppSizes.h8),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          style: Theme.of(context).textTheme.labelSmall,

          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          decoration: InputDecoration(hintText: "$hint", counterText: ''),
        ),
      ],
    );
  }
}
