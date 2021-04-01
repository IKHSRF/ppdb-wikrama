import 'package:flutter/material.dart';

class DetailField extends StatelessWidget {
  const DetailField({
    Key key,
    @required this.hintText,
  }) : super(key: key);

  final hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
