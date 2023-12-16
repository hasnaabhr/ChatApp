import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void ShowSnackBar(BuildContext context, {required message, required color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}
