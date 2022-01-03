import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    required this.errors,
  });

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String? error}) {
    return Row(
      ////mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(error!),
      ],
    );
  }
}
