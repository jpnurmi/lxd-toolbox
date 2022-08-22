import 'package:flutter/material.dart';

Future<void> showPreferencesDialog({required BuildContext context}) async {
  return showDialog(
    context: context,
    builder: (context) => const PreferencesDialog(),
  );
}

class PreferencesDialog extends StatelessWidget {
  const PreferencesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = context.watch<PreferencesModel>();
    return AlertDialog(
      title: const Text('Preferences'),
      content: const SizedBox(
        width: 900,
        height: 600,
        child: Center(
          child: Text('TODO'),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        )
      ],
    );
  }
}
