import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class DefaultTextFormField extends StatefulWidget {
  final String label;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final  List<TextInputFormatter>? inputFormatters;
  const DefaultTextFormField({ super.key, required this.label, this.obscureText, this.controller, this.keyboardType, this.validator, this.inputFormatters });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
   @override
   Widget build(BuildContext context) {
       return TextFormField(
        validator: widget.validator,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        cursorColor: Colors.black,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.black),
          labelText: widget.label,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
       );
  }
}