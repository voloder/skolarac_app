import 'package:flutter/material.dart';

class SkolaracDugme extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SkolaracDugme({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: TextButton(
          onPressed: onPressed,
          child: Text(text),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary),
            foregroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.onPrimary),
            textStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.headline6!),
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.all(12)),
          )),
    );
  }
}
