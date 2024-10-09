import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? hintText;
  final String? defaultValue;
  final TextEditingController controller;

  const TextInput({
    super.key,
    this.hintText,
    this.defaultValue,
    required this.controller,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    if (widget.defaultValue != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.defaultValue!;
    }

    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText ?? '',
      ),
    );
  }
}
