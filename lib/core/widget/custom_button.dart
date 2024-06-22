import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? buttonText;
  const CustomButton({super.key, this.onPressed, this.buttonText});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.blue,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3))),
        ),
        child: Text(
          buttonText ?? "",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }
}
