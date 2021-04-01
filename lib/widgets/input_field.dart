import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    @required this.textEditingController,
    @required this.hintText,
    this.inputNumber = false,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final bool inputNumber;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: inputNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
