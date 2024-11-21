import 'package:flutter/material.dart';

class BelowKeyboard extends StatefulWidget {
  final Widget child;

  const BelowKeyboard({super.key, required this.child});

  @override
  State<BelowKeyboard> createState() => _BelowKeyboardState();

}

class _BelowKeyboardState extends State<BelowKeyboard> {
  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.addListener(_focusListener);
  }

  void _focusListener() {
    if (FocusManager.instance.primaryFocus == null || FocusManager.instance.primaryFocus is FocusScopeNode) {
      setState(() {
        _keyboardVisible = false;
      });
    } else {
      bool hasF = FocusManager.instance.primaryFocus!.hasPrimaryFocus;
      if (_keyboardVisible == hasF) {
        return;
      }
      setState(() {
        _keyboardVisible = hasF;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    FocusManager.instance.removeListener(_focusListener);
  }

  @override
  Widget build(BuildContext context) {
    if (_keyboardVisible) {
      return const SizedBox.shrink();
    } else {
      return widget.child;
    }
  }

}