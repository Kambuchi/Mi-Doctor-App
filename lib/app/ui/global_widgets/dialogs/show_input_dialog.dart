import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> showInputDialog(
  BuildContext context, {
  String? title,
  String? initialValue,
}) async {
  String value = initialValue ?? '';

  final result = await showCupertinoDialog<String>(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      content: CupertinoTextField(
        controller: TextEditingController()..text = initialValue ?? '',
        onChanged: (text) {
          value = text;
        },
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context, value);
          },
          child: const Text("GUARDAR"),
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("CANCELAR"),
          isDestructiveAction: true,
        ),
      ],
    ),
  );

  if (result != null && result.trim().isEmpty) {
    return null;
  }
  return result;
}
