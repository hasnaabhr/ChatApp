import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextfield extends StatelessWidget {
  CustomFormTextfield(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.obscureText = false,
      required this.icon});
  final String hintText;
  final Icon icon;
  bool? obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        obscureText: obscureText!,
        // ignore: body_might_complete_normally_nullable
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is requires';
          }
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: kPrimaryColor,
            fontSize: 18,
          ),
          //suffixIcon: const Icon(Icons.email),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
