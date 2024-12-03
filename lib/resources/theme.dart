import 'package:flutter/material.dart';

class MyTheme {
  static const Color BACKGROUND_COLOR = Color.fromARGB(255, 255, 231, 179);
  static const Color FOREGROUND_COLOR = Color.fromARGB(255, 255, 242, 214);
  static const Color PRIMARY_COLOR = Color.fromARGB(255, 140, 10, 40);
  static const Color PRIMARY_COLOR_LIGHT = Color.fromARGB(255, 240, 163, 181);
  static const Color ACCENT_COLOR = Color.fromARGB(255, 33, 62, 24);
  static const Color ACCENT_COLOR_LIGHT = Color.fromARGB(255, 159, 206, 145);

  static const TextStyle TITLE_TEXT_STYLE = TextStyle(
      color: ACCENT_COLOR,
      height: 1.0,
      fontSize: 30,
      fontWeight: FontWeight.bold);

  static const TextStyle SUBTITLE_TEXT_STYLE = TextStyle(
      color: PRIMARY_COLOR,
      height: 1.0,
      fontSize: 24,
      fontStyle: FontStyle.italic);

  static const TextStyle BODY_TEXT_STYLE = TextStyle(
      color: PRIMARY_COLOR,
      height: 1.0,
      fontSize: 18,
      fontWeight: FontWeight.normal);

  static const TextStyle HINT_TEXT_STYLE = TextStyle(
      color: ACCENT_COLOR_LIGHT,
      height: 1.0,
      fontSize: 18,
      fontStyle: FontStyle.italic);
      
  static const TextStyle INPUT_TEXT_STYLE = TextStyle(
      color: ACCENT_COLOR,
      height: 1.0,
      fontSize: 18,
      fontWeight: FontWeight.normal);
  static const TextStyle ERROR_TEXT_STYLE = TextStyle(
      color: Colors.red,
      height: 1.0,
      fontSize: 12,
      fontWeight: FontWeight.normal);
}

class MyTitle extends StatelessWidget {
  final String text;

  const MyTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(text,
          textAlign: TextAlign.center, style: MyTheme.TITLE_TEXT_STYLE),
    );
  }
}

class MySubtitle extends StatelessWidget {
  final String text;

  const MySubtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(text,
          textAlign: TextAlign.start, style: MyTheme.SUBTITLE_TEXT_STYLE),
    );
  }
}

class MyBodyText extends StatelessWidget {
  final String text;

  const MyBodyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(text,
          textAlign: TextAlign.start, style: MyTheme.BODY_TEXT_STYLE),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const MyElevatedButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: MyTheme.ACCENT_COLOR_LIGHT,
            foregroundColor: MyTheme.ACCENT_COLOR,
            textStyle: MyTheme.BODY_TEXT_STYLE,
            padding: const EdgeInsets.all(8),
            fixedSize: const Size(200.0, 100.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
        onPressed: () => onPressed(),
        child: Text(text, textAlign: TextAlign.center));
  }
}
