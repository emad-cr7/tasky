import 'package:flutter/material.dart';

class CustomTextFromFeild extends StatelessWidget {
  const CustomTextFromFeild({
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
        Text(title,
          style: Theme.of(context,).textTheme.displaySmall!.copyWith (fontSize: 16),
        ),
        SizedBox(height: 8),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium ,
          validator: validator != null ?  (String? value) => validator!(value)  : null,
          decoration: InputDecoration(
              hintText: "$hint", counterText: ''),
        ),
      ],
    );
  }
}
