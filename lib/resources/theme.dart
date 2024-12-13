import 'package:flutter/material.dart';

class MyTheme {
  static const Color BACKGROUND_COLOR = Color.fromARGB(255, 201, 204, 255);
  static const Color FOREGROUND_COLOR = Color.fromARGB(255, 222, 223, 255);
  static const Color PRIMARY_COLOR = Color.fromARGB(255, 133, 35, 58);
  static const Color PRIMARY_COLOR_LIGHT = Color.fromARGB(255, 213, 138, 155);
  static const Color ACCENT_COLOR = Color.fromARGB(255, 43, 80, 31);
  static const Color ACCENT_COLOR_LIGHT = Color.fromARGB(255, 163, 195, 155);

  static const Icon IDEA = Icon(
      Icons.lightbulb,
      color: MyTheme.PRIMARY_COLOR,
      size: 50,
  );
  static const Icon DOOR = Icon(
    Icons.door_back_door,
    size: 50
  );

  static const TextStyle TITLE_TEXT_STYLE = TextStyle(
      color: ACCENT_COLOR,
      height: 1.0,
      fontSize: 30,
      fontWeight: FontWeight.bold);

  static const TextStyle SUBTITLE_TEXT_STYLE = TextStyle(
      color: PRIMARY_COLOR,
      height: 1.0,
      fontSize: 24,
      fontStyle: FontStyle.italic,);

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
  static const TextStyle STRIKE_THROUGH_BODY_TEXT_STYLE = TextStyle(
      color: PRIMARY_COLOR,
      height: 1.0,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.lineThrough);
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
          textAlign: TextAlign.center, style: MyTheme.SUBTITLE_TEXT_STYLE),
    );
  }
}

class MyBodyText extends StatelessWidget {
  final String text;
  final bool strikeThrough;

  const MyBodyText({super.key, required this.text, this.strikeThrough = false});

  @override
  Widget build(BuildContext context) {

    Text textWidget;
    if (strikeThrough) {
      textWidget = Text(
        text,
        textAlign: TextAlign.start,
        style: MyTheme.STRIKE_THROUGH_BODY_TEXT_STYLE,
      );
    } else {
      textWidget = Text(
        text,
        textAlign: TextAlign.start,
        style: MyTheme.BODY_TEXT_STYLE,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4),
      child: textWidget
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
            fixedSize: const Size(150.0, 75.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
        onPressed: () => onPressed(),
        child: Text(text, textAlign: TextAlign.center));
  }
}
