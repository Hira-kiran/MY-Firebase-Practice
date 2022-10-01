import 'package:flutter/material.dart';

class Components extends StatelessWidget {
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final loading;

  const Components({super.key, required this.text, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 360,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: loading
            ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 5,
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
      ),
    );
  }
}
