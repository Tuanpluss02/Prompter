import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class DotInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String stepValue;
  final Function(String) onChanged;
  final Function(String) onCompleted;

  const DotInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.stepValue,
    required this.onChanged,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      controller: controller,
      obscureText: true,
      closeKeyboardWhenCompleted: false,
      focusNode: focusNode,
      showCursor: false,
      onChanged: onChanged,
      onCompleted: onCompleted,
      defaultPinTheme: PinTheme(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
      submittedPinTheme: PinTheme(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
      focusedPinTheme: PinTheme(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: stepValue.length < 4 ? Colors.grey.shade400 : Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
      followingPinTheme: PinTheme(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
