import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.iconData,
      this.validate,
      this.onChange,
      this.textEditingController,
      this.onTap,})
      : super(key: key);

  final String hint;
  final IconData iconData;
  final Function()? onTap;
  final Function(String)? onChange;
  final String? Function(String?)? validate;
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validate ??
          (val) {
            if (val!.isEmpty) {
              return 'required';
            } else {
              return null;
            }
          },
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
