import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  final String title;
  final Function(String)? onChanged;
  final String? initialText;
  final String Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final int? maxLength;
  final bool isPasswordField;
  const PrimaryTextField(
      {Key? key,
      required this.title,
      this.onChanged,
      this.initialText,
      this.textInputAction,
      this.validator,
      this.controller,
      this.maxLength,
      this.isPasswordField = false,
      this.textInputType})
      : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  BorderRadius get borderRadius => BorderRadius.circular(14);

  OutlineInputBorder get inputBorder => OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      );

  bool showPassword = true;

  toggle() {
    showPassword = !showPassword;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLength ?? 1,
        obscureText: (widget.isPasswordField) ? showPassword : false,
        decoration: InputDecoration(
          errorBorder: inputBorder,
          suffixIcon: (widget.isPasswordField)
              ? IconButton(
                  onPressed: () => toggle(),
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                )
              : null,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.title,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
