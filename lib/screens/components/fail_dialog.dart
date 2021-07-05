import 'package:flutter/material.dart';

import '../size_config.dart';

class FailDialog extends StatelessWidget {
  const FailDialog({
    Key? key,
    required this.context,
    this.title,
    this.message,
  }) : super(key: key);

  final BuildContext context;
  final String? title, message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? ""),
      content: Text(message ?? ""),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Try again",
              style: TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}
