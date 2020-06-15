import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final IconData prefixIcon;
  final Widget suffixIcon;
  Function onChange;
  Function validator;

  MyFormField({
    this.hintText,
    this.isPassword,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        filled: true,
        labelText: hintText,
        focusColor: Colors.blue,
        prefixIcon: Icon(
          prefixIcon,
          color: Color(0xFF757076),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
